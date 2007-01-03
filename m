From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] sata_inic162x: driver for initio 162x SATA controllers,
 take 2
Date: Wed, 03 Jan 2007 17:18:02 +0900
Message-ID: <459B66BA.2010405@gmail.com>
References: <20061217014827.GK5400@htj.dyndns.org> <20061217015008.GL5400@htj.dyndns.org> <20061220062546.GA4823@htj.dyndns.org> <45899560.8090401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:18695 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbXACISQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jan 2007 03:18:16 -0500
Received: by an-out-0708.google.com with SMTP id b33so78683ana
        for <linux-ide@vger.kernel.org>; Wed, 03 Jan 2007 00:18:15 -0800 (PST)
In-Reply-To: <45899560.8090401@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, alan@lxorguk.ukuu.org.uk, matthias@urlichs.de, romieu@fr.zoreil.com, carlosmarcelomartinez@gmail.com

Jeff Garzik wrote:
>> + * - ATA disks work.
>> + * - Hotplug works.
>> + * - ATAPI read works but burning doesn't.  This thing is really
>> + *   peculiar about ATAPI and I couldn't figure out how ATAPI PIO and
>> + *   ATAPI DMA WRITE should be programmed.  If you've got a clue, be
>> + *   my guest.
>> + * - Both STR and STD work.
> 
> Do everyday users get a sane error, or something bad like a lockup, when
> trying to ATAPI write?

It will simply fail.  No lock up.

>> +struct inic_port_priv {
>> +    u8 dfl_prdctl, cached_prdctl;
> 
>> +    u8 cached_pirq_mask;
> 
> apply standard struct style:
> 
> 1) one struct member per line
> 2) indent between type and member name

Okay.

>> +static void set_pirq_mask(struct ata_port *ap, u8 mask)
>> +{
>> +    struct inic_port_priv *pp = ap->private_data;
>> +
>> +    if (pp->cached_pirq_mask != mask)
>> +        __set_pirq_mask(ap, mask);
>> +}
> 
> 
> You should either flush here, or in the one case you need it, ->thaw

Still dazed and scared about those flushes.  Will add it to ->freeze and
->thaw.

>> +static u32 inic_scr_read(struct ata_port *ap, unsigned sc_reg)
>> +{
>> +    void __iomem *scr_addr = (void __iomem *)ap->ioaddr.scr_addr;
>> +    if (sc_reg < ARRAY_SIZE(scr_map)) {
>> +        void __iomem *addr;
>> +        u32 val;
>> +
>> +        addr = scr_addr + scr_map[sc_reg] * 4;
>> +        val = readl(scr_addr + scr_map[sc_reg] * 4);
>> +
>> +        /* this controller has stuck DIAG.N, ignore it */
>> +        if (sc_reg == SCR_ERROR)
>> +            val &= ~SERR_PHYRDY_CHG;
>> +        return val;
>> +    }
>> +    return 0xffffffffU;
>> +}
> 
> style:  the main body of code should not be indented.
> 
> more appropriate:
> 
>     if (unlikely(sc_reg >= ARRAY_SIZE(scr_map)))
>         return 0xffffffffU;
>     ...
> 
> Or perhaps audit the code and ensure that the core never calls with an
> SCR index greater than 2 (SCR_CONTROL), and then add
> 
>     BUG_ON(sc_ref > SCR_CONTROL);

I'll take the first option for the time being.

>> +static void inic_error_handler(struct ata_port *ap)
>> +{
>> +    void __iomem *port_base = get_port_base(ap);
>> +    struct inic_port_priv *pp = ap->private_data;
>> +    unsigned long flags;
>> +
>> +    /* reset PIO HSM and stop DMA engine */
>> +    reset_port(port_base);
> 
> This function name is a bit too generic, and more difficult to narrow
> down to the single driver when viewed in an oops stack trace

Will add inic_ prefixes.

>> +static void inic_dev_config(struct ata_port *ap, struct ata_device *dev)
>> +{
>> +    /* inic can only handle upto LBA28 max sectors */
>> +    if (dev->max_sectors > ATA_MAX_SECTORS)
>> +        dev->max_sectors = ATA_MAX_SECTORS;
>> +}
> 
> why is this needed?  scsi host template should take care of this, right?

No, not really.  This is the only and correct place to configure max
sectors.  We do 'blk_queue_max_sectors(sdev->request_queue,
dev->max_sectors)' unconditionally during slave_config().

Thanks.

-- 
tejun
