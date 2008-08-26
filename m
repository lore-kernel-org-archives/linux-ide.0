From: Mark Lord <liml@rtr.ca>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 18:37:56 -0400
Message-ID: <48B485C4.2030502@rtr.ca>
References: <20080826072841.GS20055@kernel.dk> <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk> <20080826101713.GW20055@kernel.dk> <48B3F7C3.6010600@wasp.net.au> <20080826124816.GA20055@kernel.dk> <48B3FD40.3000109@kernel.org> <20080826130657.GB20055@kernel.dk> <20080826135822.GE20055@kernel.dk> <48B45B33.1050703@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55643 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbYHZWiB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 18:38:01 -0400
In-Reply-To: <48B45B33.1050703@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Tejun Heo <tj@kernel.org>, Brad Campbell <brad@wasp.net.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Jens Axboe wrote:
>> OK, something like this. Jeff, if you think this is fine, let me know
>> and I'll submit a proper patch with description and so on.
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 79e3a8e..879ceac 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -2100,6 +2100,10 @@ retry:
>>  static inline u8 ata_dev_knobble(struct ata_device *dev)
>>  {
>>      struct ata_port *ap = dev->link->ap;
>> +
>> +    if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
>> +        return 0;
>> +
>>      return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
>>  }
>>  
>> @@ -3998,6 +4002,9 @@ static const struct ata_blacklist_entry 
>> ata_device_blacklist [] = {
>>      { "TSSTcorp CDDVDW SH-S202N", "SB00",      ATA_HORKAGE_IVB, },
>>      { "TSSTcorp CDDVDW SH-S202N", "SB01",      ATA_HORKAGE_IVB, },
>>  
>> +    /* Devices that do not need bridging limits applied */
>> +    { "Mtron",        NULL,        0, },

Err.. shouldn't there be an ATA_HORKAGE_BRIDGE_OK on that line?
Or did Jens already repost a corrected patch..

>> +
>>      /* End Marker */
>>      { }
>>  };
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 225bfc5..9f194c0 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -364,6 +364,7 @@ enum {
>>      ATA_HORKAGE_IPM        = (1 << 7),    /* Link PM problems */
>>      ATA_HORKAGE_IVB        = (1 << 8),    /* cbl det validity bit 
>> bugs */
>>      ATA_HORKAGE_STUCK_ERR    = (1 << 9),    /* stuck ERR on next 
>> PACKET */
>> +    ATA_HORKAGE_BRIDGE_OK    = (1 << 10),    /* no bridge limits */
>>  
>>       /* DMA mask for user DMA control: User visible values; DO NOT
>>          renumber */
> 
> 
> This one seems fine to me...
..
