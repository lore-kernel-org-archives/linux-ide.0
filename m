From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] atapi request sense work
Date: Fri, 21 May 2004 20:39:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405212036.08190.bzolnier@elka.pw.edu.pl>
References: <1084717146.3576.3.camel@patibmrh9> <200405211746.35015.bzolnier@elka.pw.edu.pl> <1085163796.833.61.camel@vom>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41685 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265973AbUEUSig
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 14:38:36 -0400
In-Reply-To: <1085163796.833.61.camel@vom>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Danny Cox <Danny.Cox@ECWeb.com>
Cc: linux-ide@vger.kernel.org

On Friday 21 of May 2004 20:23, Danny Cox wrote:
> Bartlomiej,
>
> On Fri, 2004-05-21 at 11:46, Bartlomiej Zolnierkiewicz wrote:
> > Keep posting... seconded.
> >
> > I'm also reading this and linux-ide needs more traffic/people. ;-)
>
> 	Okay, here's some more ;-).
>
> 	I've been lurking up to this point, but I've attached a patch that
> fixes something that's been an irritation to me for awhile now (at least
> two years plus).
>
> 	It's especially relevant now too, with the i386 4K stack in place.  In
> ide.c, ide_unregister(), old_hwif is allocated on the stack.  The little
> sucker is over 1K all by itself!  So, I've modified the code to use
> kmalloc().
>
> 	It may not be right, but I'd still like to see some form of it used.
> I'm still a newbie, so please don't flame me to a crisp if I've
> committed a grave sin.  Thanks!

You do 'goto abort' while not holding locks.

Anyway this is the minor issue,
the major issue is that...  you are late 52 hours... ;-)

Similar patch from Chris Wedgwood has been merged recently.

http://linus.bkbits.net:8080/linux-2.5/user=B.Zolnierkiewicz/cset@40ab7239LJqW0C3mhBU9Fv8BPbo0CA?nav=!-|index.html|stats|!+|index.html|ChangeSet@-3d

