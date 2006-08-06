From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/9] libata: implement per-dev xfermask
Date: Sun, 06 Aug 2006 23:41:20 +0900
Message-ID: <44D5FF90.7000602@gmail.com>
References: <11547252932391-git-send-email-htejun@gmail.com> <1154785137.10971.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:22361 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932551AbWHFOl3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 10:41:29 -0400
Received: by py-out-1112.google.com with SMTP id z74so964767pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 07:41:29 -0700 (PDT)
In-Reply-To: <1154785137.10971.20.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, davej@redhat.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

Alan Cox wrote:
> Ar Sad, 2006-08-05 am 06:01 +0900, ysgrifennodd Tejun Heo:
>> +	/* Use the lowest common PIO mode to avoid violating device
>> +	 * selection timing.
>> +	 */
>> +	for (i = 0; i < ATA_MAX_DEVICES; i++) {
>> +		struct ata_device *d = &ap->device[i];
>> +		if (!ata_dev_absent(d))
>> +			xfer_mask &= ata_pack_xfermask(d->pio_mask,
>> +						       UINT_MAX, UINT_MAX);
>>  	}
> 
> We should not do this. Many of the controllers are smart enough to get
> it right and those which do not implement this logic internally and
> correctly by merging the relevant fields in the ata timing structure.

[Cc'ing Mark Lord for upstream PATA drivers]

I see.  I have a question though.  ATM, there are a few drives in the 
current #upstream which deal with PATA devices (ata_piix, pdc_adma and 
sata_promise).  Will they all act correctly without the above logic?  If 
so, I'll drop the above part and regenerate the tree.  If not, it can 
stay till those drivers are patched.

Thanks.

-- 
tejun
