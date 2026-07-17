#include <zephyr/device.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/init.h>
#include <zephyr/kernel.h>

#define LED_PAIR_MS 250
#define LED_PAUSE_MS 1000
#define LED_COUNT 8
#define LED_COLUMN_COUNT 4

static const struct gpio_dt_spec leds[LED_COUNT] = {
    GPIO_DT_SPEC_GET(DT_NODELABEL(led1), gpios),
    GPIO_DT_SPEC_GET(DT_NODELABEL(led2), gpios),
    GPIO_DT_SPEC_GET(DT_NODELABEL(led3), gpios),
    GPIO_DT_SPEC_GET(DT_NODELABEL(led4), gpios),
    GPIO_DT_SPEC_GET(DT_NODELABEL(led5), gpios),
    GPIO_DT_SPEC_GET(DT_NODELABEL(led6), gpios),
    GPIO_DT_SPEC_GET(DT_NODELABEL(led7), gpios),
    GPIO_DT_SPEC_GET(DT_NODELABEL(led8), gpios),
};

static uint8_t active_column;
static bool pause_after_cycle;

static void advance_leds(struct k_work *work);

K_WORK_DELAYABLE_DEFINE(led_work, advance_leds);

static void advance_leds(struct k_work *work) {
    ARG_UNUSED(work);

    if (pause_after_cycle) {
        for (size_t led = 0; led < LED_COUNT; led++) {
            gpio_pin_set_dt(&leds[led], false);
        }

        pause_after_cycle = false;
        active_column = 0;
        k_work_schedule(&led_work, K_MSEC(LED_PAUSE_MS));
        return;
    }

    for (size_t led = 0; led < LED_COUNT; led++) {
        bool is_active = led == active_column || led == active_column + LED_COLUMN_COUNT;
        gpio_pin_set_dt(&leds[led], is_active);
    }

    if (active_column == LED_COLUMN_COUNT - 1) {
        pause_after_cycle = true;
    } else {
        active_column++;
    }

    k_work_schedule(&led_work, K_MSEC(LED_PAIR_MS));
}

static int protomidi_running_leds_init(void) {
    for (size_t led = 0; led < LED_COUNT; led++) {
        if (!gpio_is_ready_dt(&leds[led])) {
            return -ENODEV;
        }

        int err = gpio_pin_configure_dt(&leds[led], GPIO_OUTPUT_INACTIVE);
        if (err != 0) {
            return err;
        }
    }

    advance_leds(NULL);
    return 0;
}

SYS_INIT(protomidi_running_leds_init, APPLICATION, CONFIG_APPLICATION_INIT_PRIORITY);
