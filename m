From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: improve and limit spurious interrupt messages,
 take#2
Date: Thu, 25 Jan 2007 16:55:23 +0900
Message-ID: <45B8626B.9090002@gmail.com>
References: <20070115090117.GL10987@htj.dyndns.org> <20070116065239.GO10987@htj.dyndns.org> <45B806DA.1050107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:54002 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965685AbXAYHz3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 02:55:29 -0500
Received: by nz-out-0506.google.com with SMTP id s1so348555nze
        for <linux-ide@vger.kernel.org>; Wed, 24 Jan 2007 23:55:29 -0800 (PST)
In-Reply-To: <45B806DA.1050107@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> -    /* ignore interim PIO setup fis interrupts */
>> -    if (ata_tag_valid(ap->active_tag) && (status & PORT_IRQ_PIOS_FIS))
>> -        return;
>> +    if ((status & PORT_IRQ_D2H_REG_FIS) &&
>> +        !(pp->seen_status & PORT_IRQ_D2H_REG_FIS)) {
>> +        ata_port_printk(ap, KERN_INFO, "D2H reg with I during NCQ, "
>> +                "this message won't be printed again\n");
>> +        pp->seen_status |= PORT_IRQ_D2H_REG_FIS;
>> +    } else if ((status & PORT_IRQ_DMAS_FIS) &&
>> +           !(pp->seen_status & PORT_IRQ_DMAS_FIS)) {
>> +        ata_port_printk(ap, KERN_INFO, "DMAS FIS during NCQ, "
>> +                "this message won't be printed again\n");
>> +        pp->seen_status |= PORT_IRQ_DMAS_FIS;
>> +    } else if (status & PORT_IRQ_SDB_FIS && pp->spurious_sdb_cnt < 10) {
>> +        /* SDB FIS containing spurious completions might be
>> +         * dangerous, we need to know more about them.  Print
>> +         * more of it.
>> +         */
>> +        const u32 *f = pp->rx_fis + RX_FIS_SDB;
> 
> 
> This if/else/else tree does not take into account the possiblity that
> more than one bit may be set.

Thought it wouldn't really matter.  Will fix.

-- 
tejun
