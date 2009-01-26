From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 20:01:43 +0000
Message-ID: <20090126200143.733b0cec@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
	<497E0548.80904@ru.mvista.com>
	<20090126190801.7d198246@lxorguk.ukuu.org.uk>
	<497E0EF3.2000201@ru.mvista.com>
	<497E101C.9040008@ru.mvista.com>
	<20090126194237.4897b6ce@lxorguk.ukuu.org.uk>
	<497E1550.1000501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55172 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751927AbZAZUU5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 15:20:57 -0500
In-Reply-To: <497E1550.1000501@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

>     I have explained everything in the prior mail. I hadn't expect you to 
> start the patch fencing.

I don't see an explanation just points I queried. I shall draw the obvious
conclusion from the fact you don't feel like providing one

The logic is this

ATA-3 or higher - that word has a defined meaning
ATA < 3 that word should be 0x0000
pre ATA (EIDE) or head up backside implementations that would will be
anything but usually 0x0000 or 0xFFFF

We cannot test for ATA < 3 because there is no version bit for it (and
in fact identify is optional which I need to fix at some point by
permitting geometry passing so that support is at parity with old IDE)

Therefore we want to check

	CFA signature -> CFA (good for CFA 1.1 and later devices using it)
	ATA >= 3 claimed - word is trustable bit is 0 or means CFA


Yes the implementation is paranoid, but having done ten years working for
a distro dealing with PC hardware in volume day in and day out I've yet
to regret being paranoid. Assuming every piece of hardware sucks, nobody
ever read the standard and every BIOS table is wrong is a staple part of
writing a robust OS for the PC platform.

Alan

