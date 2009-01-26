From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 20:33:19 +0000
Message-ID: <20090126203319.783b0d2d@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
	<497E0548.80904@ru.mvista.com>
	<20090126190801.7d198246@lxorguk.ukuu.org.uk>
	<497E0F76.6020606@ru.mvista.com>
	<20090126193550.27eef301@lxorguk.ukuu.org.uk>
	<497E12BC.1080809@ru.mvista.com>
	<20090126195430.3a8aa1ce@lxorguk.ukuu.org.uk>
	<497E1700.8090206@ru.mvista.com>
	<497E191A.1040902@pobox.com>
	<497E1BB8.8010408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45701 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751968AbZAZUeP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 15:34:15 -0500
In-Reply-To: <497E1BB8.8010408@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

> totally wrong in that part from the very start -- CF devices don't report ATA 
> standard support in word 80, that's forbidden (!) by the CF specs since at 
> least 2.1.

And the ATA world says that if word 80 doesn't report any standards then
the word is potentially undefined....welcome to PC hell

Perhaps the best we can do is to test

	word 80 == 0 && word 83 bit set && word 83 valid

Fortunately the use is almost entirely to print the right CFA/ATA string
at boot ?

Now Sergei if you'd said that explicitly (or if you did before I didn't
see it) it would have been a bit simpler to work out why you were arguing
the needed for these changes.

Alan
