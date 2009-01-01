From: Mark Lord <liml@rtr.ca>
Subject: Re: marvell sata status?
Date: Thu, 01 Jan 2009 09:07:11 -0500
Message-ID: <495CCE0F.7010002@rtr.ca>
References: <20090101051038.GD3386@pimb.org> <alpine.DEB.1.10.0901010444440.427@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:50429 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbZAAOFm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jan 2009 09:05:42 -0500
In-Reply-To: <alpine.DEB.1.10.0901010444440.427@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Jody Belka <lists-lkml@pimb.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Justin Piszcz wrote:
> On Thu, 1 Jan 2009, Jody Belka wrote:
> .. One of the cards I've spotted is an Adaptec
>> that apparently has a Marvell chipset on it (88SX7042), so I was 
>> wondering
>> what the current state of sata_mv is. Is it stable enough for everyday 
>> use, or should I look for something using a different chipset?
..
> I cannot comment on that Adaptec card but other cards (without fake-raid 
> controllers built on-top of them) with that chipset work great:
..

The Marvell 7042 (PCIe) and 6042 (PCI) chips are very stable
and full-featured with the current sata_mv driver in Linux.

The older 6081 and 6041 chips still have issues with Linux,
something I'm working on fixing early in 2009.

Cheers
