From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH,RFC] sata_mv: don't avoid clearing interrupt status on SoC
	host adapters
Date: Mon, 12 Jan 2009 13:27:57 -0800
Message-ID: <da824cf30901121327v29f6080eq8ac97b7c8daa7001@mail.gmail.com>
References: <20080824030429.GA10230@xi.wantstofly.org>
	 <20090110184127.GA18111@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:52384 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbZALV2F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2009 16:28:05 -0500
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id n0CLS2wF016059
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2009 13:28:02 -0800
Received: from yx-out-1718.google.com (yxh36.prod.google.com [10.190.2.228])
	by wpaz29.hot.corp.google.com with ESMTP id n0CLRvxT028917
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2009 13:27:58 -0800
Received: by yx-out-1718.google.com with SMTP id 36so3276961yxh.26
        for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2009 13:27:57 -0800 (PST)
In-Reply-To: <20090110184127.GA18111@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>

On Sat, Jan 10, 2009 at 10:41 AM, Martin Michlmayr <tbm@cyrius.com> wrote:
> * Lennert Buytenhek <buytenh@wantstofly.org> [2008-08-24 05:04]:
>> For some reason, sata_mv doesn't clear interrupt status during init
>> when it's running on an SoC host adapter.  If the bootloader has
>> touched the SATA controller before starting Linux, Linux can end up
>> enabling the SATA interrupt with events pending, which will cause the
>> interrupt to be marked as spurious and then be disabled, which then
>> breaks all further accesses to the controller.
>>
>> This patch makes the SoC path clear interrupt status on init like in
>> the non-SoC case.
>
> What's the status of this patch?  Saeed said that the patch is correct [1]
> and Mark asked for his Signed-off-by.  Saeed, can you add your
> Signed-off-by, so this can go in?

"Acked-by:" is already implied with Saeed's previous email:
    "The patch looks fine."

That should be sufficient.
This patch can be applied by jgarzik to libata tree.

hth,
grant

>
> [1] http://www.spinics.net/lists/linux-ide/msg25686.html
>
>> Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
>> ---
>>  drivers/ata/sata_mv.c |   21 ++++++++++-----------
>>  1 files changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index ad169ff..e829a3a 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -3131,19 +3131,18 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
>>               writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
>>       }
>>
>> -     if (!IS_SOC(hpriv)) {
>> -             /* Clear any currently outstanding host interrupt conditions */
>> -             writelfl(0, mmio + hpriv->irq_cause_ofs);
>> +     /* Clear any currently outstanding host interrupt conditions */
>> +     writelfl(0, mmio + hpriv->irq_cause_ofs);
>>
>> -             /* and unmask interrupt generation for host regs */
>> -             writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
>> +     /* and unmask interrupt generation for host regs */
>> +     writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
>> +
>> +     /*
>> +      * enable only global host interrupts for now.
>> +      * The per-port interrupts get done later as ports are set up.
>> +      */
>> +     mv_set_main_irq_mask(host, 0, PCI_ERR);
>>
>> -             /*
>> -              * enable only global host interrupts for now.
>> -              * The per-port interrupts get done later as ports are set up.
>> -              */
>> -             mv_set_main_irq_mask(host, 0, PCI_ERR);
>> -     }
>>  done:
>>       return rc;
>>  }
>> --
>> 1.5.6.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Martin Michlmayr
> http://www.cyrius.com/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
