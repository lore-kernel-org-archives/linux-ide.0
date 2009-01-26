From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 23:41:27 +0300
Message-ID: <497E1FF7.9000900@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com>	<20090126190801.7d198246@lxorguk.ukuu.org.uk>	<497E0F76.6020606@ru.mvista.com>	<20090126193550.27eef301@lxorguk.ukuu.org.uk>	<497E12BC.1080809@ru.mvista.com>	<20090126195430.3a8aa1ce@lxorguk.ukuu.org.uk>	<497E1700.8090206@ru.mvista.com>	<497E191A.1040902@pobox.com>	<497E1BB8.8010408@ru.mvista.com> <20090126203319.783b0d2d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4935 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754837AbZAZUk5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 15:40:57 -0500
In-Reply-To: <20090126203319.783b0d2d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:

>>totally wrong in that part from the very start -- CF devices don't report ATA 
>>standard support in word 80, that's forbidden (!) by the CF specs since at 
>>least 2.1.

> And the ATA world says that if word 80 doesn't report any standards then
> the word is potentially undefined....

    It's all your fantasy this time. :-D
    Do start reading the specs attentively. All ATA standards only have that 
if bits 14:15 are not 1:0, the words are not valid (as a variant, if the word 
is 0 or 0xFFFF).

 > welcome to PC hell

    I've started on PCs, and spent "the best years of my life" with them -- no 
need to welcome me. :-)

> Perhaps the best we can do is to test

> 	word 80 == 0 && word 83 bit set && word 83 valid

> Fortunately the use is almost entirely to print the right CFA/ATA string
> at boot ?

    What about PIO/DMA modes?

> Now Sergei if you'd said that explicitly (or if you did before I didn't
> see it) it would have been a bit simpler to work out why you were arguing
> the needed for these changes.

    If you think that I now have plenty of time to look into all the CF and 
ATA standard, you are very wrong. However, you caused me to lose much time on 
that pointless argument...

> Alan

MBR, Sergei
