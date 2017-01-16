From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 03/10] devicetree: bindings: add bindings for ahci-da850
Date: Mon, 16 Jan 2017 12:47:59 -0600
Message-ID: <fb93275e-73ad-513b-6ac8-a39bbe43fd5c@lechnology.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-4-git-send-email-bgolaszewski@baylibre.com>
 <35ff358d-9b17-b2be-38d8-6a51cdddc1a1@lechnology.com>
 <CAMpxmJUau9BgAOhacPvcA=NwyE6-yEfDgPdcCZ_JCuNH-amJSA@mail.gmail.com>
 <d8406f53-b97d-ca9a-f7d1-94ce5b7064f7@ti.com>
 <CAMpxmJW9ns-aG=4zYHcV5-2b_TdmJ7q+Ap1jdyoxstZjWYRL2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJW9ns-aG=4zYHcV5-2b_TdmJ7q+Ap1jdyoxstZjWYRL2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-ide@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On 01/16/2017 08:30 AM, Bartosz Golaszewski wrote:
> 2017-01-16 13:45 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>> On Monday 16 January 2017 03:43 PM, Bartosz Golaszewski wrote:
>>> 2017-01-13 20:25 GMT+01:00 David Lechner <david@lechnology.com>:
>>>>
>>>> A clock multiplier property seems redundant if you are specifying a clock.
>>>> It should be possible to get the rate from the clock to determine which
>>>> multiplier is needed.
>>>>
>>>
>>> I probably should have named it differently. This is not a multiplier
>>> of a clock derived from PLL0 or PLL1. Instead it's a value set by
>>> writing to the Port PHY Control Register (MPY bits) of the SATA
>>> controller that configures the multiplier for the external low-jitter
>>> clock. On the lcdk the signals (REFCLKP, REFCLKN) are provided by
>>> CDCM61001 (SATA OSCILLATOR component on the schematics).
>>>
>>> I'll find a better name and comment the property accordingly.
>>>
>>> FYI: the da850 platform does not use the common clock framework, so I
>>> don't specify the clock property on the sata node in the device tree.
>>> Instead I add the clock lookup entry in patch [01/10]. This is
>>> transparent for AHCI which can get the clock as usual by calling
>>> clk_get() in ahci_platform_get_resources().
>>
>> I think David's point is that the SATA_REFCLK needs to be modeled as a
>> actual clock input to the IP. You should be able to get the rate using
>> clk_get_rate() and make the MPY bits calculation depending on the
>> incoming rate.
>>
>> You should be able to model the clock even when not using common clock
>> framework.
>>
>> DA850 AHCI does not use a con_id at the moment (it assumes a single
>> clock), and that needs to change.
>>
>
> It's true that once davinci gets ported (is this planned?) to using
> the common clock framework, we could just create a fixed-clock node in
> da850-lcdk for the SATA oscillator, so the new property is redundant.
>

I have some commits[1] where I started on converting da850 to use the 
common clock framework. But, I don't know anything about other davinci 
family devices, so I don't think I could really take that to completion 
without lots of help.

[1]: https://github.com/dlech/ev3dev-kernel/commits/wip-20160509

> What I don't get is how should I model a clock that is not
> configurable and is board-specific? Is hard-coding the relevant rate
> in da850.c with a huge FIXME the right way?

In arch/arm/mach-davinci/usb-da8xx.c, there is a "usb_refclkin" that is 
very similar to the situation with the sata refclk. You could do 
something like this to register the clock...

---

diff --git a/arch/arm/mach-davinci/devices-da8xx.c 
b/arch/arm/mach-davinci/devices-da8xx.c
index c2457b3..790efce9 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1023,6 +1023,34 @@ int __init da8xx_register_spi_bus(int instance, 
unsigned num_chipselect)
  }

  #ifdef CONFIG_ARCH_DAVINCI_DA850
+
+static struct clk sata_refclkin = {
+       .name           = "sata_refclkin",
+       .set_rate       = davinci_simple_set_rate,
+};
+
+static struct clk_lookup sata_refclkin_lookup =
+       CLK(NULL, "sata_refclkin", &sata_refclkin);
+
+/**
+ * da8xx_register_sata_refclkin - register SATA_REFCLKIN clock
+ *
+ * @rate: The clock rate in Hz
+ */
+int __init da850_register_sata_refclkin(int rate)
+{
+       int ret;
+
+       sata_refclkin.rate = rate;
+       ret = clk_register(&sata_refclkin);
+       if (ret)
+               return ret;
+
+       clkdev_add(&sata_refclkin_lookup);
+
+       return 0;
+}
+
  static struct resource da850_sata_resources[] = {
         {
                 .start  = DA850_SATA_BASE,
@@ -1055,8 +1083,11 @@ static struct platform_device da850_sata_device = {

  int __init da850_register_sata(unsigned long refclkpn)
  {
-       /* please see comment in drivers/ata/ahci_da850.c */
-       BUG_ON(refclkpn != 100 * 1000 * 1000);
+       int err;
+
+       err = da850_register_sata_refclkin(refclkpn);
+       if (err)
+               return err;

         return platform_device_register(&da850_sata_device);
  }

---

Then to get things working from device tree, add this...

---

diff --git a/arch/arm/mach-davinci/da8xx-dt.c 
b/arch/arm/mach-davinci/da8xx-dt.c
index d2be194..b54bdd6 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -60,6 +60,14 @@ static void __init da850_init_machine(void)
                 pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
                         __func__, ret);

+       if (of_machine_is_compatible("ti,da850-evm") ||
+           of_machine_is_compatible("ti,da850-lcdk")) {
+               ret = da850_register_sata_refclkin(100000000);
+               if (ret)
+                       pr_warn("%s: registering SATA_REFCLK clock 
failed: %d",
+                               __func__, ret);
+       }
+
         of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
         davinci_pm_init();
         pdata_quirks_init();

---
