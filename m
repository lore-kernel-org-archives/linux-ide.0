From: Fabian Knittel <fabian.knittel@avona.com>
Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4,
 SATA 300 TX4
Date: Sat, 01 Apr 2006 00:52:13 +0200
Message-ID: <442DB29D.1010102@avona.com>
References: <43FFAE3D.7010002@physics.harvard.edu> <44000036.7070403@eyal.emu.id.au> <011f01c639f9$8dc86bc0$3d64880a@speedy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lenk.info ([217.160.183.176]:30698 "EHLO mail.lenk.info")
	by vger.kernel.org with ESMTP id S1751380AbWCaWw3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 17:52:29 -0500
In-Reply-To: <011f01c639f9$8dc86bc0$3d64880a@speedy>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Christiaan den Besten <chris@scorpion.nl>, Jeff Garzik <jgarzik@pobox.com>, milan@physics.harvard.edu

Hi all,

correct me if I'm wrong, but apparently this issue hasn't been taken
care of yet and I've only seen reports of "wrong wiring" ... where
everyone apart from the current linux driver sees correct wiring.

In other words: The boards appear to be wired correctly (or maybe just
uniformly the wrong way) and the bios, the windows driver and the closed
source promise driver (reportedly) know how to handle it.

We have a SATA 150 TX4 board with the same behaviour and would love to
see this annoying little bug fixed in linux. :)

  Fabian

[ More context for reference. (No new text below.) ]
Christiaan den Besten wrote:
> We have several of these boards in use [SATA 300 TX4] (bought over time
> .. not in one batch). All of them have the ordering as described below.
> So another vote for "Please fix!" :)
>
> ----- Original Message ----- From: "Eyal Lebedinsky" <eyal@eyal.emu.id.au>
> To: "Milan Kupcevic" <milan@physics.harvard.edu>
> Cc: "Jeff Garzik" <jgarzik@pobox.com>; <linux-ide@vger.kernel.org>;
> <linux-scsi@vger.kernel.org>; <linux-kernel@vger.kernel.org>;
> <trivial@rustcorp.com.au>; <torvalds@osdl.org>
> Sent: Saturday, February 25, 2006 7:59 AM
> Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150
> TX4, SATA 300 TX4
> 
> 
>> Milan Kupcevic wrote:
>>
>>> From: Milan Kupcevic <milan@physics.harvard.edu>
>>>
>>> Fix Promise SATAII 150 TX4 (PDC40518) and Promise SATA 300 TX4
>>> (PDC40718-GP) wrong port enumeration order that makes it (nearly)
>>> impossible to deal with boot problems using two or more drives.
>>>
>>> Signed-off-by: Milan Kupcevic <milan@physics.harvard.edu>
>>> ---
>>>
>>> The current kernel driver assumes:
>>>
>>> port 1 - scsi3
>>> port 2 - scsi1
>>> port 3 - scsi0
>>> port 4 - scsi2
>>
>>
>> I totally agree with the fact that the Linux driver gets the ports wrong
>> when compared to the BIOS, Windows and surely contradicts the port
>> numbers printed on the board. I doubt we all got samples on the one
>> bad batch...
>>
>> It *is* a real problem and if the solution is correct then I support it.
>>
>> Maybe we need a quick feedback from current users: do you guys find
>> that the ports are detected as they are labelled (white silk screen)
>> on the board or do they show up out of order (as listed above by
>> Milan)?
-- 
avona media GbR      | Neureuter Str. 5-7   | D-76185 Karlsruhe
fon +49 721 53169901 | fax +49 721 53169904 | www.avona.com
