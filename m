From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
Date: Sat, 11 Sep 2004 18:02:45 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409111802.45628.bzolnier@elka.pw.edu.pl>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de> <200409102321.17042.bzolnier@elka.pw.edu.pl> <4142D3AE.5050602@inet6.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:26555 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268210AbUIKRAd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Sep 2004 13:00:33 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:36750 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S99556AbUIKQ76 (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sat, 11 Sep 2004 18:59:58 +0200
Received: from chello062179066128.chello.pl ([62.179.66.128]:61995 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S71331AbUIKQCA (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 3 others);
	Sat, 11 Sep 2004 18:02:00 +0200
In-Reply-To: <4142D3AE.5050602@inet6.fr>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Saturday 11 September 2004 12:30, Lionel Bouton wrote:
> Bartlomiej Zolnierkiewicz wrote the following on 09/10/2004 11:21 PM :
> 
> >>I see it's not really a cutting-edge design (2002). Apparently nobody 
> >>seemed to care about Linux IDE performance before :-|
> >>    
> >>
> >
> >Yep. :/  Lionel, can I push this fix upstream?
> >  
> >
> 
> Please do.

OK, will do.

> In fact I think I'm only a speed bumper here. There's so little work to 
> do on the sis5513 driver now that I don't follow IDE work closely 
> anymore and must refresh my memories even for such simple patches. I 
> believe there are people around more fit than me for sis5513 maintenance.

I'm not aware of any such person...

> With SATA, sis5513.c will soon be considered legacy code. I don't think 
> a dedicated maintainer is usefull anymore, seems to me it would be 
> better handled by someone with a broader view of IDE chipsets than me.

Dedicated maintainers are very useful even for legacy drivers.
This way the subsystem maintainer doesn't have to worry about
every fscking driver (less bugs, faster development). :-)

If you really want to give up maintainership of sis5513 please
send a patch to Linus+me removing you from MAINTAINERS file.

Anyway, thanks for all your hard work on sis5513 driver.
