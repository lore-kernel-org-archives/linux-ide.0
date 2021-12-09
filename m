Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3D1C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 07:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhLIHVc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 02:21:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56684 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhLIHVb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 02:21:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E678121763;
        Thu,  9 Dec 2021 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639034277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9nFsnj8DQVJ41KvIS3AdH0AVpAFUUONJAmUQvBLN40=;
        b=uR7NRu/KZCvA3svYral/FmR12TrGR2Qm4tq3FXbPFPuVtY9GTSSTXXRSOlvmdVlPO/ec0n
        WpLFIIfnTGstNDsfsYrZ4j1Oo2HAzaKwXHwzaVxFzEMeolz6C+PWDdl95U0ALNzugFc5Hz
        Bgrs0MuDVM3MJPgTwJhvr7hU5sCkqaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639034277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9nFsnj8DQVJ41KvIS3AdH0AVpAFUUONJAmUQvBLN40=;
        b=KULhk0Q1QzooYbe5+6LqelRc5IhdaECkMpJJz0h0maq7SrRJXSetBkTkiZDP0PFniOAaxa
        lWY9rYKXUsxunhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B451113CA2;
        Thu,  9 Dec 2021 07:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +OiHKaWtsWG/LgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 09 Dec 2021 07:17:57 +0000
Subject: Re: [PATCH 05/73] sata_mv: replace DPRINTK with 'pci_dump' module
 parameter
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-6-hare@suse.de>
 <6fc0936f-d220-69c4-a76b-f68485a078bd@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c0891706-61c9-ff2d-c199-b15fde712040@suse.de>
Date:   Thu, 9 Dec 2021 08:17:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6fc0936f-d220-69c4-a76b-f68485a078bd@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/21 1:38 AM, Damien Le Moal wrote:
> On 2021/12/09 1:31, Hannes Reinecke wrote:
>> Implement module parameter 'pci_dump' and move the DPRINTK calls
>> over to dev_printk().
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>   drivers/ata/sata_mv.c | 88 ++++++++++++++++++++++++-------------------
>>   1 file changed, 49 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index cae4c1eab102..f0257685495f 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -83,6 +83,10 @@ module_param(irq_coalescing_usecs, int, S_IRUGO);
>>   MODULE_PARM_DESC(irq_coalescing_usecs,
>>   		 "IRQ coalescing time threshold in usecs");
>>   
>> +static int pci_dump;
>> +module_param(pci_dump, int, S_IRUGO);
>> +MODULE_PARM_DESC(pci_dump, "Enable dumping of PCI registers on error");
>> +
>>   enum {
>>   	/* BAR's are enumerated in terms of pci_resource_start() terms */
>>   	MV_PRIMARY_BAR		= 0,	/* offset 0x10: memory space */
>> @@ -1248,42 +1252,43 @@ static int mv_stop_edma(struct ata_port *ap)
>>   	return err;
>>   }
>>   
>> -#ifdef ATA_DEBUG
>> -static void mv_dump_mem(void __iomem *start, unsigned bytes)
>> +static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
>>   {
>> -	int b, w;
>> +	int b, w, o;
>> +	unsigned char linebuf[38];
>> +
>>   	for (b = 0; b < bytes; ) {
>> -		DPRINTK("%p: ", start + b);
>> -		for (w = 0; b < bytes && w < 4; w++) {
>> -			printk("%08x ", readl(start + b));
>> +		for (w = 0, o = 0; b < bytes && w < 4; w++) {
>> +			o += snprintf(linebuf + o, 38 - o,
>> +				      "%08x ", readl(start + b));
>>   			b += sizeof(u32);
>>   		}
>> -		printk("\n");
>> +		dev_printk(KERN_DEBUG, dev, "%s: %p: %s\n",
>> +			   __func__, start + b, linebuf);
> 
> Why not dev_dbg() ? Same comment for all the prints below.
> 
Because the entire thing is encapsulated by the 'pci_dump' parameter, ie 
it'll be only ever called when 'pci_dump' is set.
So it feels redundant to require both, 'pci_dump' _and_ dynamic debugging.

But I can move it over to dynamic debugging and kill the pci_dump parameter.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
