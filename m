From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Sun, 23 Sep 2007 15:49:27 +0100
Message-ID: <46F67CF7.3080407@genesi-usa.com>
References: <46C69913.1060505@g7.org>	<46C799E8.8080407@rtr.ca>	<20070819175632.349d11c5@the-village.bc.nu>	<46EC70A0.1000800@g7.org> <20070922191248.5f2bc74a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:3285 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbXIWOrp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 10:47:45 -0400
In-Reply-To: <20070922191248.5f2bc74a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Malcolm Gillies <malcolm@g7.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org


Alan Cox wrote:
>> I've acquired a new CF card that is capable of UDMA2, and with the same 
>> connectors, wiring and adaptor (i.e. I popped out the MWDMA card and 
>> inserted the UDMA one), I can now boot and read data on both devices 
>> without error at reasonable speeds.
> 
> Fascinating. Does point more to a driver funny you are right. At the
> moment I'm at a loss to guess what

Why would it be a driver quirk just because it now works when it didn't
before?

There are plenty of completely WEIRD people out there who install SCSI
systems in a Y configuration with a controller in the middle and both
ends terminated (or one end not or one end with a real terminator and
the other using drive termination) which is totally out of spec and
so on but *works* just fine by some random chance of chipset, drives and
cable length..

Doesn't UDMA checksum transfers, where MWDMA doesn't - or some drive to
controller intervention which would silently retry where MWDMA would
just pop it's guts all over your system?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
