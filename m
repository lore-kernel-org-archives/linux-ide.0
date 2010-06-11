From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v3] libata: pata_samsung_cf: Add Samsung PATA controller
 driver
Date: Fri, 11 Jun 2010 13:48:53 +0400
Message-ID: <4C120685.8030306@mvista.com>
References: <1276156241-28804-1-git-send-email-kgene.kim@samsung.com> <4C10C1D6.8080708@ru.mvista.com> <003301cb0937$e04412c0$a0cc3840$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <003301cb0937$e04412c0$a0cc3840$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, jgarzik@pobox.com, 'Abhilash Kesavan' <a.kesavan@samsung.com>, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Kukjin Kim wrote:

>>> From: Abhilash Kesavan <a.kesavan@samsung.com>
>>> Adds support for the Samsung PATA controller. This driver is based on the
>>> Libata subsystem and references the earlier patches sent for IDE subsystem.

> Hi,

> Thanks for your comments.

>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> [...]

>>> diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
>>> new file mode 100644
>>> index 0000000..fef5515
>>> --- /dev/null
>>> +++ b/drivers/ata/pata_samsung_cf.c
>>> @@ -0,0 +1,608 @@
>>> +/* linux/drivers/ata/pata_samsung_cf.c

>>     File names in the heading comment are discouraged.

> Hmm. I used like that in other device drivers.

    Nevertheless, it's quite an old rule already.

> Ok..will remove the file name in the heading comment.

>> [...]

>>> +
>>> +	piotime = (t2i << 12) | (t2 << 4) | t1;
>>> +
>>> +	return piotime;
>>> +}
>>> +
>>> +static void pata_s3c_set_piomode(struct ata_port *ap, struct ata_device *adev)
>>> +{
>>> +	int mode = adev->pio_mode - XFER_PIO_0;
>>> +	struct s3c_ide_info *info = ap->host->private_data;
>>> +	ulong ata_cfg = readl(info->ide_addr + S3C_ATA_CFG);
>>> +	ulong piotime;
>>> +
>>> +	/* Calculates timing parameters for PIO mode */
>>> +	piotime = pata_s3c_setup_timing(info, adev);

>>     In fact, for 8-bit (command) timing you should program the slowest mode  of
>> the two drives. However, with CF, you probably only have only one drive per
>> channel...

> Below code looks OK ?

    No, it doesn't.

> 	if (ata_timing_compute(adev, adev->pio_mode, &timing, cycle_time, 0))
> {
> 		dev_err(ap->dev, "Failed to compute ATA timing\n");
> 		piotime = pata_s3c_setup_timing(info, &initial_timing);
> 	} else {
> 		piotime = pata_s3c_setup_timing(info, &timing);
> 	}
> where initial_timing is for PIO0. I have added the below struct

> static const struct ata_timing initial_timing =
> 	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 0, 600, 0};

    I'd call ata_timing_find_mode(XFER_PIO_0) rather than duplicating the 
ata_timing entry. But really, you shouldn't set any timing for an invalid mode 
and, as I said, you won't be passed one, so there's nor much sense in calling 
ata_timing_compute() and checking its result; anyway, you'd want to call 
ata_timing_find_mode() here instead of ata_timing_compute() because the latter 
returns already quantized timings, but initial_timing is not quantized, you'll 
have to call ata_timing_compute() in pata_s3c_setup_timing() anyway.

>>> +
>>> +	/* Enables IORDY if mode requires it */
>>> +	if (ata_pio_need_iordy(adev))
>>> +		ata_cfg |= S3C_ATA_CFG_IORDYEN;
>>> +	else
>>> +		ata_cfg &= ~S3C_ATA_CFG_IORDYEN;
>>> +
>>> +	/* Host controller supports upto PIO4 only */
>>> +	if (mode >= 0 && mode <= 4) {

>>     No need to check -- you won't be passed a mode not specified by your
>> pio_mask.

> Will remove the check.

>>> +static int __devinit pata_s3c_probe(struct platform_device *pdev)
[...]
>>> +	if (!request_mem_region(res->start, resource_size(res), DRV_NAME)) {

>>     Probably should call devm_request_mem_region() if you're using
>> devm_ioremap()...

> Will change to devm_request_mem_region.

    This function does exist, if I don't mistake...

>>> +release_mem:
>>> +	release_mem_region(res->start, resource_size(res));
>>> +release_device_mem:
>>> +	kfree(info);

>>     Doesn't using devm_kzalloc() guarantee that the memory will be freed up
>> automatically?

> Will remove kfree and release_mem_region because of devm_kzalloc and
> devm_request_mem_region usage

    I don't know devres librarry capabilities well. Tejun, am I right?

>>> +static struct platform_driver pata_s3c_driver = {
>>> +	.probe		= pata_s3c_probe,
>>>
>>>

>>     2 empty lines -- broken patch?

> Seems OK at my end.

    The sent patch had them, nevertheless.

MBR, Sergei
