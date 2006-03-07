From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/6] libata: add xfer_mask handling functions
Date: Tue, 07 Mar 2006 15:47:12 +0900
Message-ID: <440D2C70.3090409@gmail.com>
References: <11415871161635-git-send-email-htejun@gmail.com> <440D1F49.5040508@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:43409 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752000AbWCGGrY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2006 01:47:24 -0500
Received: by zproxy.gmail.com with SMTP id 13so1419514nzn
        for <linux-ide@vger.kernel.org>; Mon, 06 Mar 2006 22:47:24 -0800 (PST)
In-Reply-To: <440D1F49.5040508@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Albert Lee wrote:
> Tejun Heo wrote:
> 
>>Add ata_pack_xfermask(), ata_xfer_mask2mode(), ata_xfer_mode2mask(),
>>ata_xfer_mode2shift() and ata_id_xfermask().  These functions will be
>>used by following patches to simplify xfer_mask handling.
>>
>>Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> (snip)
>>+/**
>>+ *	ata_id_xfermask - Compute xfermask from the given IDENTIFY data
>>+ *	@id: IDENTIFY data to compute xfer mask from
>>+ *
>>+ *	Compute the xfermask for this device. This is not as trivial
>>+ *	as it seems if we must consider early devices correctly.
>>+ *
>>+ *	FIXME: pre IDE drive timing (do we care ?).
>>+ *
>>+ *	LOCKING:
>>+ *	None.
>>+ *
>>+ *	RETURNS:
>>+ *	Computed xfermask
>>+ */
>>+static unsigned int ata_id_xfermask(const u16 *id)
>>+{
>>+	unsigned int pio_mask, mwdma_mask, udma_mask;
>>+
>>+	/* Usual case. Word 53 indicates word 64 is valid */
>>+	if (id[ATA_ID_FIELD_VALID] & (1 << 1)) {
>>+		pio_mask = id[ATA_ID_PIO_MODES] & 0x03;
>>+		pio_mask <<= 3;
>>+		pio_mask |= 0x7;
>>+	} else {
>>+		/* If word 64 isn't valid then Word 51 high byte holds
>>+		 * the PIO timing number for the maximum. Turn it into
>>+		 * a mask.
>>+		 */
>>+		pio_mask = (2 << (id[ATA_ID_OLD_PIO_MODES] & 0xFF)) - 1 ;
>>+
>>+		/* But wait.. there's more. Design your standards by
>>+		 * committee and you too can get a free iordy field to
>>+		 * process. However its the speeds not the modes that
>>+		 * are supported... Note drivers using the timing API
>>+		 * will get this right anyway
>>+		 */
>>+	}
>>+
>>+	mwdma_mask = id[ATA_ID_MWDMA_MODES] & 0x07;
>>+	udma_mask = id[ATA_ID_UDMA_MODES] & 0xff;
>>+
>>+	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
>>+}
>>+
>> /*
> 
> 
> We have ap->pio_mask, ap->mwdma_mask and ap->udma_mask.
> Just thinking what if we have these masks in ata_device? 

We need those masks in both ap and dev. ap capability should be stored 
in ap->*_mask and dev capabilities in dev->*_mask. e.g. speed limits due 
to controller quirks should be done by limiting ap->*_mask in 
->dev_config() while device speeding down due to transmission errors 
should be done by limiting dev->*_mask.

> Maybe we can save some bitwise operations and make the code more intuitive to read?
> 
> Ex. ata_id_xfermask() can store the calculated masks to dev->pio_mask, dev->mwdma_mask, etc.

This will be done when adding dev->*_mask.

> Ex. ata_mode_string() can take mode (XFER_UDMA_7..) as parameter and translate the given mode to string.

Hmmm... I don't know. My plan is to unify transfer mode handling to 
unsigned int xfer_mask in libata core layer proper. It's easier to pass 
around, mask, manipulate, etc... That's why I made ata_mode_string() 
take xfer_mask instead of mode constants. But I'm okay either way. 
Converting back and forth between xfermask and mode constant isn't 
difficult.

> Ex. to print out the max mode support by the device, 
>     1. ata_id_xfermask() calculates and saves the masks to dev->pio_mask, etc.
>     2. Another function, say, ata_dev_max_mode() takes dev as parameter,
>        packs the mode by ata_pack_xfermask() internally,
>        find the max mode supported by the drive,
>        then use ata_xfer_mask2mode() to return the mode.
>     3. ata_mode_string() translates the mode, say XFER_UDMA_7, to string literal.

Hmm.. 1, 2 and 3 can just be done like the following.

printk("max speed=%s\n", ata_mode_string(ata_id_xfermask(id));

I think it's simpler this way. No?

-- 
tejun
