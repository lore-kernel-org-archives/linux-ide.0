From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Tue, 05 Aug 2008 20:30:01 -0600
Message-ID: <48990CA9.2060107@shaw.ca>
References: <fa.OGeO7gZvBG4obEzRbVltjSebgTQ@ifi.uio.no> <fa.KtvYE2B2yrJqUleolhtMPN9ljAQ@ifi.uio.no> <fa.AqEKTvguYFAzDFHy/We/8MpOqmo@ifi.uio.no> <48976168.3020804@shaw.ca> <20080804205508.20a3f917@lxorguk.ukuu.org.uk> <48977200.3050307@shaw.ca> <20080804220619.76b94ceb@lxorguk.ukuu.org.uk> <4898EE70.1030604@shaw.ca> <4898F3EA.7000507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:34969 "EHLO
	pd5mo1no-dmz.prod.shaw.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752817AbYHFCaI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 22:30:08 -0400
In-Reply-To: <4898F3EA.7000507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> Robert Hancock wrote:
>> Here's my first cut at it. Compile tested only. This sets most controllers
>> to use 32-bit PIO except for those which could potentially be on a real ISA
>> or other 16-bit bus. It's a bit non-obvious what to do with some of the
>> drivers, so input is welcome.
>>
>> This implementation doesn't check the ata_id_has_dword_io at all, since it
>> would only make a difference on controllers where we don't really want to
>> use it anyway.
>>
>> It seems like regardless of whether we do 32-bit by default or not the 32-bit
>> data_xfer function should be added to libata core as we have several drivers
>> which duplicate the same code currently..
> 
> Great, just some minor nitpicks as I don't have much idea about 16 bit ones.
> 
>> +unsigned int ata_sff_data_xfer(struct ata_device *dev, unsigned char *buf,
>> +			       unsigned int buflen, int rw)
>> +{
>> +	struct ata_port *ap = dev->link->ap;
>> +	void __iomem *data_addr = ap->ioaddr.data_addr;
>> +	unsigned int words = buflen >> 2;
> 
> dwords maybe?
> 
>> +	unsigned int slop = buflen & 3;
>> +
>> +	/* Transfer multiple of 4 bytes */
>> +	if (rw == READ)
>> +		ioread32_rep(data_addr, buf, words);
>> +	else
>> +		iowrite32_rep(data_addr, buf, words);
>> +
>> +	/* Transfer trailing 1 byte, if any. */
> 
> 1byte?

Yeah, those are both leftovers from the 16-bit code. I'll fix them up in 
the next version, if the approach looks good..

> 
> Thanks.
> 
