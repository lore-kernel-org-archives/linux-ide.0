From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] ata: add new-style AHCI platform driver for DaVinci
	DA850 AHCI controller
Date: Thu, 20 Mar 2014 18:53:09 +0530
Message-ID: <532AEBBD.80707@ti.com>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
	<1395081118-15248-4-git-send-email-b.zolnierkie@samsung.com>
	<532AA2B0.1060103@ti.com> <2662651.GJX9HVKij5@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <2662651.GJX9HVKij5@amdc1032>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Thursday 20 March 2014 06:27 PM, Bartlomiej Zolnierkiewicz wrote:

>>> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c

>>> +extern void __iomem *da8xx_syscfg1_base;
>>
>> This platform specific extern symbol should not be used in drivers and
>> in fact checkpatch complains about it too. Can you instead get the
>> addresses you need as part of the device resources?
> 
> This is problematic because it is system resource not particular device
> resource.  I would prefer to wait with fixing it until the conversion to
> the device tree.

The way you have it now, module build will fail because the symbol isn't
exported from platform code (and it should not be). The register is
"system level" but it is SATA specific and I see no problem in passing
it to the driver.

Conversion to device tree will not change anything until we throw out
the platform device code. That may or may not ever happen.

>>> +static int da850_sata_init(struct device *dev, void __iomem *addr)
>>> +{
>>> +	int i, ret;
>>> +	unsigned int val;
>>> +
>>> +	da850_sata_clk = clk_get(dev, NULL);
>>> +	if (IS_ERR(da850_sata_clk))
>>> +		return PTR_ERR(da850_sata_clk);
>>> +
>>> +	ret = clk_prepare_enable(da850_sata_clk);
>>> +	if (ret)
>>> +		goto err0;
>>
>> Please switch to pm_runtime instead of using the clock APIs directly.
> 
> Could you please elaborate a bit more on this?

I meant using pm_runtime_get_sync() to enable the clocks. There are many
examples in the kernel. drivers/watchdog/omap_wdt.c is one.
Documentation is available in Documentation/power/runtime_pm.txt

>>> +static struct platform_device_id ahci_da850_platform_ids[] = {
>>> +	{ .name = "ahci" },
>>
>> I was not able to get this driver probed with this name (I guess that
>> was because the generic driver was picked instead?). Can you please
> 
> Yes, the generic driver should be disabled to use this one.

>> change it to "da850-sata"?
> 
> I prefer to remove the ids table (so the "ahci_da850" driver name is
> used) and update the platform device name accordingly.  This would also
> allow me to remove the old ahci_platform_data code in this patch.
> 
> Is this OK with you?

Fine with me. Sounds good.

Thanks,
Sekhar
