From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 23:31:55 +0300
Message-ID: <497E1DBB.80709@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com>	<20090126190801.7d198246@lxorguk.ukuu.org.uk>	<497E0EF3.2000201@ru.mvista.com>	<497E101C.9040008@ru.mvista.com>	<20090126194237.4897b6ce@lxorguk.ukuu.org.uk>	<497E1550.1000501@ru.mvista.com> <20090126200143.733b0cec@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4739 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751987AbZAZUbZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 15:31:25 -0500
In-Reply-To: <20090126200143.733b0cec@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:

>>    I have explained everything in the prior mail. I hadn't expect you to 
>>start the patch fencing.

> I don't see an explanation just points I queried.

    Have you seen this mail:

http://marc.info/?l=linux-ide&m=123299798729575

    If you haven't, read it. After you have, the argument must be over.

> I shall draw the obvious conclusion from the fact you don't feel like providing one

> The logic is this

> ATA-3 or higher - that word has a defined meaning
> ATA < 3 that word should be 0x0000
> pre ATA (EIDE) or head up backside implementations that would will be
> anything but usually 0x0000 or 0xFFFF

> We cannot test for ATA < 3 because there is no version bit for it

    That's not quite true, read the ATA-3 standard better.

> Therefore we want to check

> 	CFA signature -> CFA (good for CFA 1.1 and later devices using it)
> 	ATA >= 3 claimed - word is trustable bit is 0 or means CFA

    The problem is that the CF specs explicitly forbid (!) to report anything 
in word 80 -- it's reserved and must be 0.

> Yes the implementation is paranoid, but having done ten years working for
> a distro dealing with PC hardware in volume day in and day out I've yet

    Working while checking word 82 ISO word 83? Who are you trying to cheat?

> to regret being paranoid.

    Again, I'm not seeing this kind of version paranoia in any place but the 
one that was wrong: ata_id_is_cfa().

> Assuming every piece of hardware sucks, nobody
> ever read the standard and every BIOS table is wrong is a staple part of
> writing a robust OS for the PC platform.

    Yes, we just had report of the CF drive which is totally unidentifiable... 
but perhaps you still should start reading the specs as more manufacturers are 
doing it now and following them?

> Alan

MBR, Sergei
