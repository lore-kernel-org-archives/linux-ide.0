From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Delkin Cardbus IDE, a.k.a. ASKA "Ninja" chipset
Date: Thu, 17 Jan 2008 23:11:16 +0000
Message-ID: <20080117231116.6fcc6453@lxorguk.ukuu.org.uk>
References: <6CC18F0C3EFF9D4DAE8286ABB9F4E23D079822@bosmail.us.aastra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56857 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756319AbYAQXMz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jan 2008 18:12:55 -0500
In-Reply-To: <6CC18F0C3EFF9D4DAE8286ABB9F4E23D079822@bosmail.us.aastra.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Iain Barker <ibarker@aastra.com>
Cc: liml@rtr.ca, linux-ide@vger.kernel.org

> I can confirm Mark's observation that the access speeds are slower - around half the speed of the earlier Linux PIO driver, and a quarter the performance of WinXP. Test CF card was a SanDisk UltraII as the target, with CB1410 (Yenta compatible TI clone) as the host CB32 controller.
> 
> The driver works, but appears to use PIO only (PIO 4 is reported, actual performance is nearer PIO 0)
> Should the UDMA modes of the CF be usable?

Due to lack of documentation - not at the moment. Even the BSD folks
haven't managed to get that bit going. Pulling the card registers for the
device in Windows PIO4 would be most useful.

> Linux throughput of 'dd bs=100MD' writing to FAT16 (Dell 3GHz P4 x86 32bit, kernel 2.6.23):
> 
>  3.1MB/sec for Linux PCMCIA     (legacy delkin_cb.c )
>  1.8MB/sec for Linux CardBus 32 (libata pata_ninja32.c)

Yes. I've not had time to go back and do more investigating.

Alan
