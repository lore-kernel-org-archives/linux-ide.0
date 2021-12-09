Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCCFC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 08:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhLIIWz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:22:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57988 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhLIIWz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 03:22:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D7681FD2A;
        Thu,  9 Dec 2021 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639037961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MQwxYV5uKONX2SvQWoGlvIxblZcOzz0xXVJ27a0Zfg=;
        b=BcaT9DXcSMEbgcxyvM1NE0pLyMq8Ulzi9bi6TOb/RaZilHBYueY9f438CQAKaBE3h7/nZb
        xDSEW2DlSz+3PvA8Q/XvDB/Zt5++Te5T4Utj2fd4+vrR6TYTbHYSDYNhevHSUZY8dXzrH3
        DZWqxYO6jchBdLXPHxGE1vFefPE2y+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639037961;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MQwxYV5uKONX2SvQWoGlvIxblZcOzz0xXVJ27a0Zfg=;
        b=uLcdblc+EiSmjs5kAnWeG/jXPxUMhSPoCaL6VzW8hfGbgcJnGpTIIxTQhEfv24S1YnTiDo
        G7dLrMTlr1dIm1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 241F613CBE;
        Thu,  9 Dec 2021 08:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PmfEBwm8sWEkRgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 09 Dec 2021 08:19:21 +0000
Subject: Re: [PATCH 06/73] sata_mv: kill 'port' argument in mv_dump_all_regs()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-7-hare@suse.de>
 <df329b28-3c1e-cddd-f9bb-986d14739848@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b9ebc310-7823-aa30-1285-e40fc96c04a3@suse.de>
Date:   Thu, 9 Dec 2021 09:19:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <df329b28-3c1e-cddd-f9bb-986d14739848@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/21 1:40 AM, Damien Le Moal wrote:
> On 2021/12/09 1:31, Hannes Reinecke wrote:
>> Always '-1', so drop it and simplify the function.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>   drivers/ata/sata_mv.c | 24 +++++++-----------------
>>   1 file changed, 7 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index f0257685495f..e86eddf83704 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -1286,23 +1286,13 @@ static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
>>   	}
>>   }
>>   
>> -static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>> -			     struct pci_dev *pdev)
>> +static void mv_dump_all_regs(void __iomem *mmio_base, struct pci_dev *pdev)
>>   {
>> -	void __iomem *hc_base = mv_hc_base(mmio_base,
>> -					   port >> MV_PORT_HC_SHIFT);
>> -	void __iomem *port_base;
>>   	int start_port, num_ports, p, start_hc, num_hcs, hc;
>>   
>> -	if (0 > port) {
>> -		start_hc = start_port = 0;
>> -		num_ports = 8;		/* shld be benign for 4 port devs */
>> -		num_hcs = 2;
>> -	} else {
>> -		start_hc = port >> MV_PORT_HC_SHIFT;
>> -		start_port = port;
>> -		num_ports = num_hcs = 1;
>> -	}
>> +	start_hc = start_port = 0;
>> +	num_ports = 8;		/* shld be benign for 4 port devs */
>> +	num_hcs = 2;
>>   	dev_printk(KERN_DEBUG, &pdev->dev,
>>   		   "%s: All registers for port(s) %u-%u:\n", __func__,
>>   		   start_port, num_ports > 1 ? num_ports - 1 : start_port);
>> @@ -1317,13 +1307,13 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>>   	mv_dump_mem(&pdev->dev, mmio_base+0xf00, 0x4);
>>   	mv_dump_mem(&pdev->dev, mmio_base+0x1d00, 0x6c);
>>   	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
>> -		hc_base = mv_hc_base(mmio_base, hc);
>> +		void __iomem *hc_base = mv_hc_base(mmio_base, hc);
> 
> please add a blank line after the declaration.
> 
>>   		dev_printk(KERN_DEBUG, &pdev->dev, "%s: HC regs (HC %i):\n",
>>   			   __func__, hc);
> 
> Change this to dev_dbg() while at it ?
> 
Okay, will do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
