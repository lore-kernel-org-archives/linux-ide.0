From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: System freeze when transferring large files (libata)
Date: Mon, 12 Jul 2004 17:41:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407121741.54643.bzolnier@elka.pw.edu.pl>
References: <opsavn7spjfmr65f@mail.broadpark.no> <Pine.LNX.4.60.0407121658180.32028@hosting.rdsbv.ro> <opsa053mjofmr65f@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14230 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266877AbUGLPgP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jul 2004 11:36:15 -0400
In-Reply-To: <opsa053mjofmr65f@mail.broadpark.no>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Arve Knudsen <aknuds-1@broadpark.no>, Catalin BOIE <util@deuroconsult.ro>
Cc: linux-ide@vger.kernel.org

On Monday 12 of July 2004 17:17, Arve Knudsen wrote:
> On Mon, 12 Jul 2004 16:59:21 +0300 (EEST), Catalin BOIE
>
> <util@deuroconsult.ro> wrote:
> > On Mon, 12 Jul 2004, Arve Knudsen wrote:
> >> I switched ports/cables, and lockup (DMA timeout) still occurs with the
> >> Maxtor only. I take it we can rule out the possibility of a quirk
> >> related  to the combination Promise/Maxtor? Looks like I'll be
> >> replacing this drive  with a Seagate soon.
> >
> > I don't know if seagate is the way to go.
> > Check the blacklist in the kernel. There are a lot of drives listed.
> > Maybe the new ones don't have that problem.
>
>  From what I recall there was a problem with Seagate and Silicon Image, no?
> My current Seagate drive seems to coexist just fine with the Promise (TX2
> Plus) controller.

Right.

