From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Time spent waiting for uncorrectable errors
Date: Thu, 19 Feb 2004 16:39:10 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402191639.10351.bzolnier@elka.pw.edu.pl>
References: <20040216082157.GK57556@vivien.franken.de> <200402191613.18342.hpj@urpla.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19434 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267285AbUBSPcs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2004 10:32:48 -0500
In-Reply-To: <200402191613.18342.hpj@urpla.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Alex Goller <alex@vivien.franken.de>, linux-ide@vger.kernel.org

On Thursday 19 of February 2004 16:13, Hans-Peter Jansen wrote:
> On Monday 16 February 2004 09:21, Alex Goller wrote:
> > Hi,
> >
> > is there any data regarding how long current disks try to read a
> > sector before quitting with an uncorrectable error? The problem is,
> > that i have no reliable way to reproduce the error, i will try to
> > read from a hopefully (!) broken disk this afternoon and try to
> > measure the time spent for that.
>
> IIRC, the kernel tries to read a defect block exactly 8 times.
>
> The problem is (according to some Maxtor guy), a drive, that returns
> a hard sector error has tried to read it internally a few tausand
> times (~2650), which results in about 21200 physical retries.
>
> Unfortunately this renders an unpatched linux kernel useless for data
> recovery tasks. Well, not useless in general, but you simply need a
> _lot_ of patience.

So where are the patches? :-)

