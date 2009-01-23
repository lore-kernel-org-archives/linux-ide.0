From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Fri, 23 Jan 2009 15:43:40 +0000
Message-ID: <20090123154340.7adf5a9e@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<20090123133352.60add80e@lxorguk.ukuu.org.uk>
	<4979CBC1.3040106@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55733 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755182AbZAWQEG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2009 11:04:06 -0500
In-Reply-To: <4979CBC1.3040106@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

> > The word 82 validity bit is not sufficient as that bit is itself not
> 
>     There's no word 82 validity bits, its validity bits are in word 83.

Word 83 sorry - I seem to have 82 and 83 bit flipped in my brain, not
good for ATA work ;)
> 
> > defined in ATA < 3. Otherwise the change looks correct.
> 
>     Well, then we need to fix every case of using *only* the validity bits in 
> ata.h. 

No reason to go removing ones that are correct
