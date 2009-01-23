From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Fri, 23 Jan 2009 16:41:52 +0000
Message-ID: <20090123164152.51327c62@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<20090123133352.60add80e@lxorguk.ukuu.org.uk>
	<4979CBC1.3040106@ru.mvista.com>
	<20090123154340.7adf5a9e@lxorguk.ukuu.org.uk>
	<4979F0C3.50501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40264 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759586AbZAWQuu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2009 11:50:50 -0500
In-Reply-To: <4979F0C3.50501@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

> > No reason to go removing ones that are correct
> 
>     You've just effectively claimed them to be incorrect with your claim what 
> validity bits are not sufficient and ATA revision must be checked. Check the 

Nope. Please go re-read what I wrote.

> source please -- I wouldn't have dropped the revision check if the rest of the 
> inlines that check word 82/82 were using it.

In other words, as I said, you removed a correct check rather than
correcting others which may not be correct.
