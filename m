From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
Date: Fri, 10 Sep 2004 23:21:16 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409102321.17042.bzolnier@elka.pw.edu.pl>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de> <1094828803.13450.4.camel@thomas.tec.linutronix.de> <4141C8C6.1030307@inet6.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:5080 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268056AbUIKAhE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Sep 2004 20:37:04 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:48730 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S53761AbUIKAgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sat, 11 Sep 2004 02:36:53 +0200
Received: from chello062179066128.chello.pl ([62.179.66.128]:62773 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S262103AbUIJVUa (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 3 others);
	Fri, 10 Sep 2004 23:20:30 +0200
In-Reply-To: <4141C8C6.1030307@inet6.fr>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Friday 10 September 2004 17:31, Lionel Bouton wrote:
> Thomas Gleixner wrote the following on 09/10/2004 05:06 PM :
> 
> >On Fri, 2004-09-10 at 16:53, Lionel Bouton wrote:
> >  
> >
> >> [...]
> >>
> >> What hardware did you use to test ?
> >>    
> >>
> >
> >Compact PCI ICP-P4 from Inova Computers.
> >
> >  
> >
> 
> I see it's not really a cutting-edge design (2002). Apparently nobody 
> seemed to care about Linux IDE performance before :-|

Yep. :/  Lionel, can I push this fix upstream?

Could somebody enlighten me what exactly 'remapping mode' does?

Bartlomiej
