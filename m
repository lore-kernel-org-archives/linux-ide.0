From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: share PIO limits among devices sharing a channel
Date: Thu, 25 Jan 2007 17:25:00 +0300
Message-ID: <45B8BDBC.20609@ru.mvista.com>
References: <20070125112947.GC8606@htj.dyndns.org> <20070125123030.3093fb32@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1202 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965366AbXAYOZM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 09:25:12 -0500
In-Reply-To: <20070125123030.3093fb32@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Alan wrote:

>>PIO xfermask limits should be shared by all devices on the same
>>channel to avoid violating device selection timing.  libata used to

    This is not a good way to deal with this. Only command block (8-bit) 
timings  should be the same for both drives on channel, data register (16-bit) 
timings may be different.

> NAK, this is totally wrong

>>+	/* PIO xfermask limits are shared by all devices on the same
>>+	 * channel to avoid violating device selection timing.
>>+	 */
>>+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
>>+		struct ata_device *d = &ap->device[i];
>>+		unsigned int pio_mask;
>>+
>>+		if (ata_dev_absent(d))
>>+			continue;
>>+
>>+		ata_unpack_xfermask(ata_id_xfermask(d->id),
>>+				    &pio_mask, NULL, NULL);
>>+		pio_mask &= d->pio_mask;
>>+		xfer_mask &= ata_pack_xfermask(pio_mask, UINT_MAX, UINT_MAX);
>>+	}

> NAK

> This "guarantee" was deliberately removed long ago and is completely
> bogus.

    I'd agree...

> The good ATA chipsets do not suffer from selection timing limits of this
> form. The less smart ones do and the drivers correctly merge the timing
> values, including a whole chunk of functionality in the ata_timing
> interface to get it right when doing DMA modes.

    I need to have a look at this (when I have time :-)...

> Adding this patch is the regression. Even the ancient drivers/ide code
> does this properly.

    Not really, at least not all drivers.  Namely, hpt366.c (still) doesn't 
merge 8-bit timings (maybe this is handled in hardware but the datasheets 
don't tell about it then) -- I need to look at fixing this... Well, it was 
even worse before "the grand rewrite" since even setting UltraDMA modes 
changed PIO timings (both 8- and 16-bit) to match PIO4 -- piix/slc90e66 are 
still doing this kind of crap (I'm going to fix this at last).

MBR, Sergei
