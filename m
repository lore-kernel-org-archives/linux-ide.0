From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 3/4] pata: imx: add support of setting timings for PIO
 modes
Date: Thu, 10 Nov 2016 03:33:22 +0200
Message-ID: <ed9bacd7-b6f4-811b-c082-ae4235a747c6@mleia.com>
References: <20161109005638.17691-1-vz@mleia.com>
 <20161109005638.17691-4-vz@mleia.com>
 <23fb0678-db2a-a0ff-65a3-3174720b0ee8@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:53964 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755158AbcKJBdZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 9 Nov 2016 20:33:25 -0500
In-Reply-To: <23fb0678-db2a-a0ff-65a3-3174720b0ee8@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

Hi Sergei,

thank you for review, I see that Tejun has applied the changes,
anyway I'll answer your questions.

On 11/09/2016 11:39 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 11/9/2016 3:56 AM, Vladimir Zapolskiy wrote:
>
>> The controller is capable to operate in up to PIO4 mode, however
>> before the change the driver relies on timing settings done by
>> a bootloader for PIO0 mode only. The change adds more flexibility
>> in PIO mode selection at runtime and makes the driver to work even if
>                                                         ^^ not needed
>
>> bootloader does not preset ATA timings.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>  drivers/ata/pata_imx.c | 47
>> ++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
>> index 00df18b..8f13c9f 100644
>> --- a/drivers/ata/pata_imx.c
>> +++ b/drivers/ata/pata_imx.c
> [...]
>> @@ -31,6 +40,10 @@
>>  #define PATA_IMX_DRIVE_DATA        0xA0
>>  #define PATA_IMX_DRIVE_CONTROL        0xD8
>>
>> +static u32 pio_t4[] = { 30,  20,  15,  10,  10 };
>> +static u32 pio_t9[] = { 20,  15,  10,  10,  10 };
>> +static u32 pio_tA[] = { 35,  35,  35,  35,  35 };
>
>    Perhaps it makes sense to extend the 'struct ata_timing'...
>
> [...]

As you guess the numbers are taken right from the ATAPI spec,
however I haven't found the second ATA controller driver sumbitted
upstream, which reuses these timings, so probably generalization
is not needed here. Anyway I would prefer if maintainers do it,
if they think that it makes sense.

>> @@ -38,11 +51,43 @@ struct pata_imx_priv {
>>      u32 ata_ctl;
>>  };
>>
>> +static void pata_imx_set_timing(struct ata_device *adev,
>> +                struct pata_imx_priv *priv)
>> +{
>> +    struct ata_timing timing;
>> +    unsigned long clkrate;
>> +    u32 T, mode;
>> +
>> +    clkrate = clk_get_rate(priv->clk);
>> +
>> +    if (adev->pio_mode < XFER_PIO_0 || adev->pio_mode > XFER_PIO_4 ||
>> +        !clkrate)
>> +        return;
>> +
>> +    T = 1000000000 / clkrate;
>> +    ata_timing_compute(adev, adev->pio_mode, &timing, T * 1000, 0);
>> +
>> +    mode = adev->pio_mode - XFER_PIO_0;
>> +
>> +    writeb(3, priv->host_regs + PATA_IMX_ATA_TIME_OFF);
>> +    writeb(3, priv->host_regs + PATA_IMX_ATA_TIME_ON);
>
>    What do those registers mean?

You may find a better description from i.MX27 or i.MX31 Reference Manual
than my retelling, the docs are open.

toff/ton timings are used to avoid bus contention when switching
BUFFER_EN signal and data writing period. AFAIK these timings are
specific to the controller only.

>> +    writeb(timing.setup, priv->host_regs + PATA_IMX_ATA_TIME_1);
>> +    writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2W);
>> +    writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2R);
>> +    writeb(1, priv->host_regs + PATA_IMX_ATA_TIME_PIO_RDX);
>
>    And this one?

This is trd timing from the ATA/ATAPI spec, "Read Data Valid to IORDY 
active", its minimal value is defined as 0.

>> +
>> +    writeb(pio_t4[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_4);
>> +    writeb(pio_t9[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_9);
>> +    writeb(pio_tA[mode] / T + 1, priv->host_regs +
>> PATA_IMX_ATA_TIME_AX);
>
>    DIV_ROUND_UP(x, T)?

Yes, it is reasonable.

--
With best wishes,
Vladimir
