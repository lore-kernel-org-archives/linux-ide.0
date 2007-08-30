From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hda: set_drive_speed_status: status=0x51 { DriveReady
 SeekComplete Error }
Date: Thu, 30 Aug 2007 15:05:40 +0100
Message-ID: <20070830150540.4455bd55@the-village.bc.nu>
References: <46D59ED2.4000900@free.fr>
	<20070829174657.09c7de3c@the-village.bc.nu>
	<46D67D09.6090101@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41768 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752242AbXH3N5O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2007 09:57:14 -0400
In-Reply-To: <46D67D09.6090101@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>          Buffer size: 1.0kB      bytes avail on r/w long: 4
> 
> (Assuming an 8-bit byte, 4 bytes = 32 bits)

R/W Long is a different thing.

> When you say "the current libata IDE" do you mean PATA_VIA (in my case)?
> I've avoided this driver because it is marked EXPERIMENTAL. Would there 
> be any benefit in using it over the legacy ATA/MFM/RLL driver?

Just less warning messages

> > Basically your dinosaur is working correctly.
> 
> What do the warnings mean? :-)

Old IDE wrongly tries to issue a set features command for PIO2 to the
device. It rejects it and old IDE carries on happy
