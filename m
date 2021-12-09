Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EDCC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 07:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhLIHTg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 02:19:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhLIHTf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 02:19:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 815A621763;
        Thu,  9 Dec 2021 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639034161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdtQGfTwfNJAMQny2DAWR9XXdNNvMGeYl7SEwjVlglw=;
        b=pPK1SrTbAuK2ulwaQpCb09wM6mM2HyMXO/X5pbUBAcecoDeCdABj70F4yTGYiFNfHKVVfF
        E5c87reRvDiVpBhm7PO2pVRQ1ZnzuXBrEOhvfXW+hRCfMQibm0clyrKP7+vB8Om7LHqKuM
        qCCjYJnvmCp7wc1aVmT1Vj4WMIw4OHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639034161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdtQGfTwfNJAMQny2DAWR9XXdNNvMGeYl7SEwjVlglw=;
        b=2PcephOlleJa5Yx5g+7WZ7UkAwiCLYpbCm5qegPvrdOKlgtkcw3BvkEeyMc0pe/SgIIW7X
        6s3PGyxBNLeDG4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B1CD13CA2;
        Thu,  9 Dec 2021 07:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q3tBGTGtsWExLgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 09 Dec 2021 07:16:01 +0000
Subject: Re: [PATCH 02/73] libata: Add ata_port_classify() helper
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-3-hare@suse.de>
 <a3368acf-d517-7a6c-04d5-44c903ceff43@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d92f9325-c1c6-e476-61d3-5ec1bf6571ee@suse.de>
Date:   Thu, 9 Dec 2021 08:16:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a3368acf-d517-7a6c-04d5-44c903ceff43@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/21 1:34 AM, Damien Le Moal wrote:
> On 2021/12/09 1:31, Hannes Reinecke wrote:
>> Add an ata_port_classify() helper to print out the results from
>> the device classification and remove the debugging statements
>> from ata_dev_classify(). Also provide a mapping ata_dev_class_string()
>> to provide a string representation for those instances calling
>> ata_dev_classify() directly.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>   drivers/ata/libahci.c       |  2 +-
>>   drivers/ata/libata-core.c   | 67 ++++++++++++++++++++++++++++---------
>>   drivers/ata/libata-sff.c    |  2 +-
>>   drivers/ata/sata_fsl.c      |  2 +-
>>   drivers/ata/sata_inic162x.c |  2 +-
>>   drivers/ata/sata_sil24.c    |  2 +-
>>   include/linux/libata.h      |  2 ++
>>   7 files changed, 58 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index 8b651f55fc84..21dbcd551443 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -1300,7 +1300,7 @@ unsigned int ahci_dev_classify(struct ata_port *ap)
>>   	tf.lbal		= (tmp >> 8)	& 0xff;
>>   	tf.nsect	= (tmp)		& 0xff;
>>   
>> -	return ata_dev_classify(&tf);
>> +	return ata_port_classify(ap, &tf);
>>   }
>>   EXPORT_SYMBOL_GPL(ahci_dev_classify);
>>   
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index f6a9e2f22a94..6cac413caf83 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -969,6 +969,27 @@ const char *sata_spd_string(unsigned int spd)
>>   	return spd_str[spd - 1];
>>   }
>>   
>> +const char *ata_dev_class_string(unsigned int class)
> 
> This should be static.
> 
Yeah; kbuild robot complained already.

>> +{
>> +	static const char * const class_str[] = {
>> +		"unknown",
>> +		"ATA",
>> +		"ATA (unsupported)",
>> +		"ATAPI",
>> +		"ATAPI (unsupported",
>> +		"PMP",
>> +		"PMP (unsupported)",
>> +		"SEMB",
>> +		"SEMB (unsupported)",
>> +		"ZAC",
>> +		"ZAC (unsupported)",
>> +		"none",
>> +	};
> 
> Add a blank line after the declaration.
> 
>> +	if (class == 0 || (class - 1) >= ARRAY_SIZE(class_str))
>> +		return "unknown";
>> +	return class_str[class - 1];
> 
> Why class - 1 ? The class_str entries directly match the values of the
> ATA_DEV_XXX macros...
> 
Yeah; and the whole thing should just go anyway, as we have the same 
functionality already present in libata-transport.c:get_ata_class_names().

>> +}
>> +
>>   /**
>>    *	ata_dev_classify - determine device type based on ATA-spec signature
>>    *	@tf: ATA taskfile register set for device to be identified
>> @@ -1007,36 +1028,50 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
>>   	 * SEMB signature.  This is worked around in
>>   	 * ata_dev_read_id().
>>   	 */
>> -	if ((tf->lbam == 0) && (tf->lbah == 0)) {
>> -		DPRINTK("found ATA device by sig\n");
>> +	if ((tf->lbam == 0) && (tf->lbah == 0))
>>   		return ATA_DEV_ATA;
>> -	}
>>   
>> -	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb)) {
>> -		DPRINTK("found ATAPI device by sig\n");
>> +	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb))
>>   		return ATA_DEV_ATAPI;
>> -	}
>>   
>> -	if ((tf->lbam == 0x69) && (tf->lbah == 0x96)) {
>> -		DPRINTK("found PMP device by sig\n");
>> +	if ((tf->lbam == 0x69) && (tf->lbah == 0x96))
>>   		return ATA_DEV_PMP;
>> -	}
>>   
>> -	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3)) {
>> -		DPRINTK("found SEMB device by sig (could be ATA device)\n");
>> +	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3))
>>   		return ATA_DEV_SEMB;
>> -	}
>>   
>> -	if ((tf->lbam == 0xcd) && (tf->lbah == 0xab)) {
>> -		DPRINTK("found ZAC device by sig\n");
>> +	if ((tf->lbam == 0xcd) && (tf->lbah == 0xab))
>>   		return ATA_DEV_ZAC;
>> -	}
>>   
>> -	DPRINTK("unknown device\n");
>>   	return ATA_DEV_UNKNOWN;
>>   }
>>   EXPORT_SYMBOL_GPL(ata_dev_classify);
>>   
>> +/**
>> + *     ata_port_classify - determine device type based on ATA-spec signature
>> + *     @ap: ATA port device on which the classification should be run
>> + *     @tf: ATA taskfile register set for device to be identified
>> + *
>> + *     A wrapper around ata_dev_classify() to provide additional logging
>> + *
>> + *     RETURNS:
>> + *     Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, %ATA_DEV_PMP,
>> + *     %ATA_DEV_ZAC, or %ATA_DEV_UNKNOWN the event of failure.
>> + */
>> +unsigned int ata_port_classify(struct ata_port *ap,
>> +			       const struct ata_taskfile *tf)
>> +{
>> +	unsigned int class = ata_dev_classify(tf);
>> +
>> +	if (class != ATA_DEV_UNKNOWN)
>> +		ata_port_dbg(ap, "found %s device by sig\n",
>> +			     ata_dev_class_string(class));
>> +	else
>> +		ata_port_dbg(ap, "found unknown device\n");
> 
> Why the if-else here ? ata_dev_class_string(() handles ATA_DEV_UNKNOWN and "bad"
> class values saying "unknown" already. So this all seems redundant. If this is
> removed, then ata_dev_class_string() could be coded in here since this is the
> sole user of that helper.
> 

Will be doing so, and removing ata_dev_class_string() in favour of the 
libata-transport routines.

Thanks for the review!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
