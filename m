From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sat, 15 May 2004 20:13:34 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405152013.34189.bzolnier@elka.pw.edu.pl>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <20040515173430.GA28873@havoc.gtf.org> <200405151958.03322.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35200 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262045AbUEOSL1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 14:11:27 -0400
In-Reply-To: <200405151958.03322.bzolnier@elka.pw.edu.pl>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 15 of May 2004 19:58, Bartlomiej Zolnierkiewicz wrote:
> > > - ide_init_hwif_ports() is obsolete and dying,
> > >   define IDE_ARCH_NO_OBSOLETE_INIT in <asm/ide.h>
> >
> > hmmmm.  Please consider reversing this:
> >
> > Make ide_init_hwif_ports() present _only_ if IDE_ARCH_OBSOLETE_INIT
> > is defined.
> >
> > Then add that define for all arches that still use ide_init_hwif_ports().
>
> Well, I started with this idea but it requires adding this define for far
> too many archs.  This is a problem especially for arm because we have to
> either leave <asm-arm/arch-*/ide.h> or add #ifdef horror <asm-arm/ide.h>.

It was thinko.  I will change this, thanks.

