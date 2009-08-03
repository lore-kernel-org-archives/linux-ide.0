From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci sometimes fails to suspend controller
Date: Mon, 03 Aug 2009 09:06:05 +0900
Message-ID: <4A7629ED.4050103@kernel.org>
References: <20090719220423.54e8c75d@uranus>	<4A683755.60909@kernel.org>	<20090727140612.27d176ca@pluto-lenny.milky.way>	<4A6E6774.6030909@kernel.org>	<C8E4BD7D001E44499280E0884BD9DB30D7CFD4@sshaexmb1.amd.com>	<20090728061033.56394c6e@pluto-lenny.milky.way>	<C8E4BD7D001E44499280E0884BD9DB30D7D051@sshaexmb1.amd.com> <20090802190838.4a8bd3b8@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51905 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbZHCAGU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Aug 2009 20:06:20 -0400
In-Reply-To: <20090802190838.4a8bd3b8@pluto-lenny.milky.way>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello, Benjamin.

Benjamin S. wrote:
> Tejun wanted me to boot with pci=nomsi about 1.5 weeks ago. The system
> was running till yesterday with many suspends and resumes in between. 
> Yesterday the system showed the first error:
> 
> [260353.116321] rtc rtc0: legacy class resume
> [260353.116362] usb usb1: type resume
> [260353.132043] r8169: eth0: link up
> [260353.196041] usb usb2: type resume
> [260353.220057] ata2: SATA link down (SStatus 0 SControl 300)
> [260353.220123] ata4: SATA link down (SStatus 0 SControl 300)
> [260353.220183] ata1: SATA link down (SStatus 0 SControl 300)
> [260353.248034] sd 2:0:0:0: legacy resume
> [260353.248038] sd 2:0:0:0: [sda] Starting disk
> [260358.264018] ata3: link is slow to respond, please be patient (ready=0)
> [260360.056034] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [260360.064939] ata3.00: configured for UDMA/133
> [260360.083650] usb 1-3: type resume
> [260360.086304] ide-cdrom 0.1: legacy resume
> [260360.089322] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> [260360.090134] hdb: UDMA/33 mode selected
> ...............
> [260360.247321] PM: Finishing wakeup.
> [260360.247323] Restarting tasks ... <3>ata3.00: exception Emask 0x50 SAct 0xff SErr 0x400800 action 0x6 frozen
> [260360.267694] ata3.00: irq_stat 0x08000000, interface fatal error
> [260360.267734] ata3: SError: { HostInt Handshk }
> [260360.267776] ata3.00: cmd 61/08:00:03:b0:6c/00:00:03:00:00/40 tag 0 ncq 4096 out
> [260360.267777]          res 40/00:3c:d3:af:6c/00:00:03:00:00/40 Emask 0x50 (ATA bus error)
...
> 
> Despite this error the system resumed and was able to suspend and resume 
> another three times. Then the system showed the same errors I have seen 
> without pci=nomsi:

The above error is a different one.  It's an ATA bus error - ie, there
was a communication error while the controller was talking to the
drive over the thin long red (why are most of them red anyway?) wire.
This happens from time to time even on a perfectly healthy system and
libata EH should be able to cope with such events just fine.

> [299254.172018] ata3: link is slow to respond, please be patient (ready=0)
> [299255.964034] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [299255.980044] sd 2:0:0:0: [sda] START_STOP FAILED
> [299255.980081] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> .........................

Can you please attach full log?  I'm curious what exactly went down.

> Does that mean the SATA MSI quirk won't solve my problem?

I think it's likely a different issue.  Can you please try to
reproduce the problem and see how many tries it usually takes?

Thanks.

-- 
tejun
