From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: SiS 180 pata
Date: Tue, 27 Jul 2004 22:54:19 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1090961659.2673.13.camel@uk3.local>
References: <200407051253.47003.ivololeribar@yahoo.it>
	 <200407071154.48626.bzolnier@elka.pw.edu.pl>
	 <200407071202.55091.bzolnier@elka.pw.edu.pl>
	 <200407071618.43587.ivololeribar@yahoo.it>
	 <1089582373.2554.8.camel@uk3.local>  <40F1B7CD.4060301@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:23196 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266640AbUG0UxQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jul 2004 16:53:16 -0400
In-Reply-To: <40F1B7CD.4060301@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Nicola <ivololeribar@yahoo.it>

Hello Jeff,

when do you expect, this new feature in libata will be available?

with best regards
Uwe Koziolek

> Uwe Koziolek wrote:
> > Hello Jeff,
> > 
> > will you support this specific constellation?, or should i try to
> > implemenent master/slave support to sata_sis and hope this will solve
> > the problem.
> 
> 
> It is a similar problem to supporting PATA port of Promise hardware, in 
> that you need to use different code paths when talking to the same 
> hardware.  It isn't as easy as the solution in ata_piix unfortunately. 
> I need to split struct ata_probe_ent into per-bus pieces, then both 
> Promise and SIS180 PATA can be supported.
> 
> 	Jeff
> 
> 

