From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: share PIO limits among devices sharing a channel
Date: Thu, 25 Jan 2007 07:44:47 -0500
Message-ID: <45B8A63F.8060305@pobox.com>
References: <20070125112947.GC8606@htj.dyndns.org> <20070125123030.3093fb32@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36324 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965278AbXAYMox (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 07:44:53 -0500
In-Reply-To: <20070125123030.3093fb32@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Alan wrote:
> On Thu, 25 Jan 2007 20:29:47 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> PIO xfermask limits should be shared by all devices on the same
>> channel to avoid violating device selection timing.  libata used to
> 
> NAK, this is totally wrong
> 
>> +	/* PIO xfermask limits are shared by all devices on the same
>> +	 * channel to avoid violating device selection timing.
>> +	 */
>> +	for (i = 0; i < ATA_MAX_DEVICES; i++) {
>> +		struct ata_device *d = &ap->device[i];
>> +		unsigned int pio_mask;
>> +
>> +		if (ata_dev_absent(d))
>> +			continue;
>> +
>> +		ata_unpack_xfermask(ata_id_xfermask(d->id),
>> +				    &pio_mask, NULL, NULL);
>> +		pio_mask &= d->pio_mask;
>> +		xfer_mask &= ata_pack_xfermask(pio_mask, UINT_MAX, UINT_MAX);
>> +	}
> 
> NAK
> 
> This "guarantee" was deliberately removed long ago and is completely
> bogus.
> 
> The good ATA chipsets do not suffer from selection timing limits of this
> form. The less smart ones do and the drivers correctly merge the timing

Agreed.

I'm curious what the motivation of this patch was?

	Jeff



