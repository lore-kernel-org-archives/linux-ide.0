From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/02] sata_mv: workaround for multi_count errata sata24
Date: Mon, 13 Apr 2009 11:46:52 -0400
Message-ID: <49E35E6C.8080409@rtr.ca>
References: <49E359D6.1090309@rtr.ca>	<49E35A5E.4020204@rtr.ca> <20090413164034.20f1695a@lxorguk.ukuu.org.uk> <49E35DC1.2090007@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:39344 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbZDMPqz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 11:46:55 -0400
In-Reply-To: <49E35DC1.2090007@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Alan Cox wrote:
>> On Mon, 13 Apr 2009 11:29:34 -0400
>> Mark Lord <liml@rtr.ca> wrote:
>>
>>> Workaround for errata SATA#24 in sata_mv.
>>> This errata affects WRITE_MULTI* commands when
>>> the device multi_count produces a DRQ block size >= 4Kbytes.
>>>
>>> We work around it here by converting such operations
>>> into ordinary PIO_WRITEs instead.
>>>
>>> Note that this might result in a PIO FUA write unavoidably being 
>>> converted
>>> into a non-FUA write.  In practice, any system using FUA is also 
>>> going to be
>>> using DMA rather than PIO, so this shouldn't affect anyone in the 
>>> real world.
>>
>> You can just screen the FUA bit from the identify data when you do the
>> drive setup to avoid that bit.
> ..
> 
> I think doing it at identify time would prevent DMA FUA commands,
> which are fine in sata_mv.
> 
> So the only place to really hit it exactly, is at command construction
> or issue time.
..

Note that libata already will convert would-be FUA commands
into non-FUA PIO commands if (dev->multi_count == 0).

So this isn't really anything new.
Nor can it be avoided.
And certainly not anything to fuss over.
