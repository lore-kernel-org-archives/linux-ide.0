From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Mon, 4 Oct 2004 23:35:37 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410042335.37109.bzolnier@elka.pw.edu.pl>
References: <1096602694.11460.29.camel@gaston> <1096851939.9516.53.camel@gaston> <1096852823.9539.61.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:8889 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268685AbUJDXAv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2004 19:00:51 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:42010 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S52567AbUJDXAq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2004 01:00:46 +0200
Received: from chello062179088136.chello.pl ([62.179.88.136]:65035 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S57852AbUJDVd0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Mon, 4 Oct 2004 23:33:26 +0200
In-Reply-To: <1096852823.9539.61.camel@gaston>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Monday 04 October 2004 03:20, Benjamin Herrenschmidt wrote:
> 
> > Ugh ? damn, that's a textboot example of crappy code ! You are
> > putting interrupt routing platform knowledge in non-platform specific
> > drivers, that is disgusting !
> 
> Please, don't take my harsh language to seriously, I missed adding
> a couple of ;)
>
> Just to summarize, I totally agree with you that the existing callbacks
> are ugly and the way of setting up on-board controllers, especially non
> PCI ones, should be to have proper controller drivers.

OK
 
> But as I think I made clear in previous mail, I'm just talking about
> the specific issue of IRQ routing for PCI controllers set in legacy mode,
> to avoid cluttering "generic" drivers with all sort of platform ifdef's
> for something that has really nothing to do with the driver logic itself...  

Maybe indeed cluttering PCI layer or arch includes with
information needed only by IDE driver is better...
