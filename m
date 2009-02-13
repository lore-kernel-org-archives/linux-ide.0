From: Mark Lord <liml@rtr.ca>
Subject: Re: EXPORT_SYMBOL_GPL(ata_pio_sectors) ?
Date: Fri, 13 Feb 2009 00:17:42 -0500
Message-ID: <49950276.2070201@rtr.ca>
References: <4994952F.9080006@rtr.ca> <49949F75.5040707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:37209 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbZBMFRo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Feb 2009 00:17:44 -0500
In-Reply-To: <49949F75.5040707@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Tejun / Jeff,
>>
>> Any objections if I EXPORT ata_pio_sectors() for use from sata_mv.c ?
..
> That's fine...
..

Well, it turns out that EXPORTing ata_pio_queue_task() was even more useful.
Patches are now awaiting your queue for 2.6.30.

No sata_mv target mode yet, but it's coming soon.

It appears that the GEN_IIE chips can be used to implement
a pretty decent SATA protocol tracer/analyzer too..

Cheers

