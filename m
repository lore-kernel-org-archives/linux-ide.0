From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: Re: [PATCH v4 2/3] pwm: iproc: Add support for Broadcom iproc pwm controller
Date: Thu, 23 Jun 2016 23:14:16 +0530
Message-ID: <CAL2FKYnn2HiZ1+GSSpErzCSvT88nUBHOgX0AvmX_eXUz7tCMOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Jaedon Shin <jaedon.shin@gmail.com>, Anup Patel <anup.patel@broadcom.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi Boris,

On Thu, Jun 23, 2016 at 11:09 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Wed, 22 Jun 2016 07:29:46 -0400
> Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com> wrote:
>
>> Add support for the PWM controller present in Broadcom's iProc
>> family of SoCs. This driver is derived from the pwm-bcm-kona
>> driver, with changes to the register offsets and bit positions.
>
> I haven't looked at the 2 drivers, but if the only difference between
> the 2 IPs is position of the fields, then maybe you should patch the
> kona driver to support both IPs...
>

The initial patches were supporting the two in the single driver. As
it is looking
complex, Thierry suggested to make it separate driver.

Thanks
Dhananjay

>> It has been tested on the  Northstar+ bcm958625HR board.
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>> ---
>>  drivers/pwm/Kconfig         |  10 ++
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-bcm-iproc.c | 327 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 338 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-bcm-iproc.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index c182efc..1339b62 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -74,6 +74,16 @@ config PWM_ATMEL_TCB
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-atmel-tcb.
>>
>> +config PWM_BCM_IPROC
>> +     tristate "iProc PWM support"
>> +     depends on ARCH_BCM_IPROC || COMPILE_TEST
>> +     help
>> +       Generic PWM framework driver for Broadcom iProc PWM block. This
>> +       block is used in Broadcom iProc SoC's.
>> +
>> +       To compile this driver as a module, choose M here: the module
>> +       will be called pwm-bcm-iproc.
>> +
>>  config PWM_BCM_KONA
>>       tristate "Kona PWM support"
>>       depends on ARCH_BCM_MOBILE
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index dd35bc1..a196d79 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_PWM_AB8500)      += pwm-ab8500.o
>>  obj-$(CONFIG_PWM_ATMEL)              += pwm-atmel.o
>>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)    += pwm-atmel-hlcdc.o
>>  obj-$(CONFIG_PWM_ATMEL_TCB)  += pwm-atmel-tcb.o
>> +obj-$(CONFIG_PWM_BCM_IPROC)  += pwm-bcm-iproc.o
>>  obj-$(CONFIG_PWM_BCM_KONA)   += pwm-bcm-kona.o
>>  obj-$(CONFIG_PWM_BCM2835)    += pwm-bcm2835.o
>>  obj-$(CONFIG_PWM_BERLIN)     += pwm-berlin.o
>> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
>> new file mode 100644
>> index 0000000..952c457
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-bcm-iproc.c
>> @@ -0,0 +1,327 @@
>> +/*
>> + * Copyright (C) 2016 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/math64.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +
>> +#define IPROC_PWM_CTRL_OFFSET                        (0x00)
>> +#define IPROC_PWM_CTRL_TYPE_SHIFT(chan)              (15 + (chan))
>> +#define IPROC_PWM_CTRL_POLARITY_SHIFT(chan)  (8 + (chan))
>> +#define IPROC_PWM_CTRL_EN_SHIFT(chan)                (chan)
>> +
>> +#define IPROC_PWM_PERIOD_OFFSET(chan)                (0x04 + ((chan) << 3))
>> +#define IPROC_PWM_PERIOD_MIN                 (0x02)
>> +#define IPROC_PWM_PERIOD_MAX                 (0xffff)
>> +
>> +#define IPROC_PWM_DUTY_CYCLE_OFFSET(chan)    (0x08 + ((chan) << 3))
>> +#define IPROC_PWM_DUTY_CYCLE_MIN             (0x00)
>> +#define IPROC_PWM_DUTY_CYCLE_MAX             (0xffff)
>> +
>> +#define IPROC_PWM_PRESCALE_OFFSET            (0x24)
>> +#define IPROC_PWM_PRESCALE_BITS                      (0x06)
>> +#define IPROC_PWM_PRESCALE_SHIFT(chan)               ((3 - (chan)) * \
>> +                                             IPROC_PWM_PRESCALE_BITS)
>> +#define IPROC_PWM_PRESCALE_MASK(chan)                (IPROC_PWM_PRESCALE_MAX << \
>> +                                             IPROC_PWM_PRESCALE_SHIFT(chan))
>> +#define IPROC_PWM_PRESCALE_MIN                       (0x00)
>> +#define IPROC_PWM_PRESCALE_MAX                       (0x3f)
>> +
>> +#define IPROC_PWM_CHANNEL_COUNT                      (0x04)
>> +
>> +struct iproc_pwmc {
>> +     struct pwm_chip chip;
>> +     void __iomem *base;
>> +     struct clk *clk;
>> +};
>> +
>> +static inline struct iproc_pwmc *to_iproc_pwmc(struct pwm_chip *_chip)
>> +{
>> +     return container_of(_chip, struct iproc_pwmc, chip);
>> +}
>> +
>> +static void iproc_pwmc_unset_enable_bit(struct iproc_pwmc *ip, u32 chan)
>> +{
>> +     unsigned int value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>> +
>> +     value &= ~(1 << IPROC_PWM_CTRL_EN_SHIFT(chan));
>> +     writel(value, ip->base + IPROC_PWM_CTRL_OFFSET);
>> +
>> +     /*
>> +      * There must be a min 400ns delay between clearing trigger and setting
>> +      * it. Failing to do this may result in no PWM signal.
>> +      */
>> +     ndelay(400);
>> +}
>> +
>> +static void iproc_pwmc_set_enable_bit(struct iproc_pwmc *ip, unsigned int chan)
>> +{
>> +     unsigned int value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>> +
>> +     /* Set trigger bit to apply new settings */
>> +     value |= 1 << IPROC_PWM_CTRL_EN_SHIFT(chan);
>> +     writel(value, ip->base + IPROC_PWM_CTRL_OFFSET);
>> +
>> +     /* Trigger bit must be held high for at least 400 ns. */
>> +     ndelay(400);
>> +}
>> +
>> +static int iproc_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> +                          int duty_ns, int period_ns, bool config_apply)
>> +{
>> +     unsigned long prescale = IPROC_PWM_PRESCALE_MIN;
>> +     struct iproc_pwmc *ip = to_iproc_pwmc(chip);
>> +     unsigned int value, chan = pwm->hwpwm;
>> +     unsigned long period_cnt, duty_cnt;
>> +     u64 val, div, rate;
>> +
>> +     rate = clk_get_rate(ip->clk);
>> +     if (!rate) {
>> +             dev_err(pwm->chip->dev, "pwm clock has no frequency\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     /*
>> +      * Find period count, duty count and prescale to suit duty_ns and
>> +      * period_ns. This is done according to formulas described below:
>> +      *
>> +      * period_ns = 10^9 * (PRESCALE + 1) * PC / PWM_CLK_RATE
>> +      * duty_ns = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
>> +      *
>> +      * PC = (PWM_CLK_RATE * period_ns) / (10^9 * (PRESCALE + 1))
>> +      * DC = (PWM_CLK_RATE * duty_ns) / (10^9 * (PRESCALE + 1))
>> +      */
>> +     while (1) {
>> +             div = 1000000000;
>> +             div *= 1 + prescale;
>> +             val = rate * period_ns;
>> +             period_cnt = div64_u64(val, div);
>> +             val = rate * duty_ns;
>> +             duty_cnt = div64_u64(val, div);
>> +
>> +             if (period_cnt < IPROC_PWM_PERIOD_MIN ||
>> +                             duty_cnt < IPROC_PWM_DUTY_CYCLE_MIN)
>> +                     return -EINVAL;
>> +
>> +             if (period_cnt <= IPROC_PWM_PERIOD_MAX &&
>> +                              duty_cnt <= IPROC_PWM_DUTY_CYCLE_MAX)
>> +                     break;
>> +
>> +             /* Otherwise, increase prescale and recalculate counts */
>> +             if (++prescale > IPROC_PWM_PRESCALE_MAX)
>> +                     return -EINVAL;
>> +     }
>> +
>> +     /*
>> +      * Don't apply settings if disabled. The period and duty cycle are
>> +      * always calculated above to ensure the new values are
>> +      * validated immediately instead of on enable.
>> +      */
>> +     if (pwm_is_enabled(pwm) || config_apply) {
>> +             iproc_pwmc_unset_enable_bit(ip, chan);
>> +
>> +             value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
>> +             value &= ~IPROC_PWM_PRESCALE_MASK(chan);
>> +             value |= prescale << IPROC_PWM_PRESCALE_SHIFT(chan);
>> +
>> +             writel(value, ip->base + IPROC_PWM_PRESCALE_OFFSET);
>> +             writel(period_cnt, ip->base + IPROC_PWM_PERIOD_OFFSET(chan));
>> +             writel(duty_cnt, ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(chan));
>> +
>> +             iproc_pwmc_set_enable_bit(ip, chan);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int iproc_pwmc_set_polarity(struct pwm_chip *chip,
>> +                                struct pwm_device *pwm,
>> +                                enum pwm_polarity polarity)
>> +{
>> +     struct iproc_pwmc *ip = to_iproc_pwmc(chip);
>> +     unsigned int chan = pwm->hwpwm;
>> +     unsigned int value;
>> +     int ret;
>> +
>> +     ret = clk_prepare_enable(ip->clk);
>> +     if (ret < 0) {
>> +             dev_err(chip->dev, "failed to enable clock: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     iproc_pwmc_unset_enable_bit(ip, chan);
>> +
>> +     value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>> +     if (polarity == PWM_POLARITY_NORMAL)
>> +             value |= 1 << IPROC_PWM_CTRL_POLARITY_SHIFT(chan);
>> +     else
>> +             value &= ~(1 << IPROC_PWM_CTRL_POLARITY_SHIFT(chan));
>> +     writel(value, ip->base + IPROC_PWM_CTRL_OFFSET);
>> +
>> +     iproc_pwmc_set_enable_bit(ip, chan);
>> +
>> +     clk_disable_unprepare(ip->clk);
>> +
>> +     return 0;
>> +}
>> +
>> +static int iproc_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     struct iproc_pwmc *ip = to_iproc_pwmc(chip);
>> +     int ret;
>> +
>> +     ret = clk_prepare_enable(ip->clk);
>> +     if (ret < 0) {
>> +             dev_err(chip->dev, "failed to enable clock: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = iproc_pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
>> +                                     pwm_get_period(pwm), true);
>> +     if (ret < 0) {
>> +             clk_disable_unprepare(ip->clk);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void iproc_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +     struct iproc_pwmc *ip = to_iproc_pwmc(chip);
>> +     unsigned int chan = pwm->hwpwm;
>> +     unsigned int value;
>> +
>> +     iproc_pwmc_unset_enable_bit(ip, chan);
>> +
>> +     writel(0, ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(chan));
>> +     writel(0, ip->base + IPROC_PWM_PERIOD_OFFSET(chan));
>> +
>> +     /* Set prescale to 0 for this channel */
>> +     value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
>> +     value &= ~IPROC_PWM_PRESCALE_MASK(chan);
>> +     writel(value, ip->base + IPROC_PWM_PRESCALE_OFFSET);
>> +
>> +     iproc_pwmc_set_enable_bit(ip, chan);
>> +
>> +     clk_disable_unprepare(ip->clk);
>> +}
>> +
>> +static int iproc_pwmc_config_check(struct pwm_chip *chip,
>> +                                 struct pwm_device *pwm,
>> +                                 int duty_ns, int period_ns)
>> +{
>> +     return iproc_pwmc_config(chip, pwm, duty_ns, period_ns, false);
>> +}
>> +
>> +static const struct pwm_ops iproc_pwm_ops = {
>> +     .config = iproc_pwmc_config_check,
>> +     .set_polarity = iproc_pwmc_set_polarity,
>> +     .enable = iproc_pwmc_enable,
>> +     .disable = iproc_pwmc_disable,
>> +     .owner = THIS_MODULE,
>> +};
>> +
>> +static int iproc_pwmc_probe(struct platform_device *pdev)
>> +{
>> +     struct iproc_pwmc *ip;
>> +     struct resource *res;
>> +     unsigned int value;
>> +     unsigned int chan;
>> +     int ret;
>> +
>> +     ip = devm_kzalloc(&pdev->dev, sizeof(*ip), GFP_KERNEL);
>> +     if (ip == NULL)
>> +             return -ENOMEM;
>> +
>> +     platform_set_drvdata(pdev, ip);
>> +
>> +     ip->chip.dev = &pdev->dev;
>> +     ip->chip.ops = &iproc_pwm_ops;
>> +     ip->chip.base = -1;
>> +     ip->chip.npwm = IPROC_PWM_CHANNEL_COUNT;
>> +     ip->chip.of_xlate = of_pwm_xlate_with_flags;
>> +     ip->chip.of_pwm_n_cells = 3;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     ip->base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(ip->base))
>> +             return PTR_ERR(ip->base);
>> +
>> +     ip->clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(ip->clk)) {
>> +             dev_err(&pdev->dev, "failed to get clock: %ld\n",
>> +                     PTR_ERR(ip->clk));
>> +             return PTR_ERR(ip->clk);
>> +     }
>> +
>> +     ret = clk_prepare_enable(ip->clk);
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     /* Set full drive and normal polarity for all channels */
>> +     value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>> +     for (chan = 0; chan < ip->chip.npwm; chan++) {
>> +             value &= ~(1 << IPROC_PWM_CTRL_TYPE_SHIFT(chan));
>> +             value |= 1 << IPROC_PWM_CTRL_POLARITY_SHIFT(chan);
>> +     }
>> +     writel(value, ip->base + IPROC_PWM_CTRL_OFFSET);
>> +
>> +     clk_disable_unprepare(ip->clk);
>> +
>> +     ret = pwmchip_add(&ip->chip);
>> +     if (ret < 0)
>> +             dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
>> +
>> +     return ret;
>> +}
>> +
>> +static int iproc_pwmc_remove(struct platform_device *pdev)
>> +{
>> +     struct iproc_pwmc *ip = platform_get_drvdata(pdev);
>> +     unsigned int chan;
>> +
>> +     for (chan = 0; chan < ip->chip.npwm; chan++)
>> +             if (pwm_is_enabled(&ip->chip.pwms[chan]))
>> +                     clk_disable_unprepare(ip->clk);
>> +
>> +     return pwmchip_remove(&ip->chip);
>> +}
>> +
>> +static const struct of_device_id bcm_iproc_pwmc_dt[] = {
>> +     { .compatible = "brcm,iproc-pwm" },
>> +     { },
>> +};
>> +MODULE_DEVICE_TABLE(of, bcm_iproc_pwmc_dt);
>> +
>> +static struct platform_driver iproc_pwmc_driver = {
>> +     .driver = {
>> +             .name = "bcm-iproc-pwm",
>> +             .of_match_table = bcm_iproc_pwmc_dt,
>> +     },
>> +     .probe = iproc_pwmc_probe,
>> +     .remove = iproc_pwmc_remove,
>> +};
>> +module_platform_driver(iproc_pwmc_driver);
>> +
>> +MODULE_AUTHOR("Broadcom Corporation");
>> +MODULE_DESCRIPTION("Broadcom iProc PWM driver");
>> +MODULE_LICENSE("GPL v2");
>
