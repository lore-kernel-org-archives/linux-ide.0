From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Fri, 28 Nov 2003 14:00:55 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200311281400.55500.bzolnier@elka.pw.edu.pl>
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <20031128022439.GA8333@complete.org> <3FC6BF5A.6050204@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11241 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261731AbTK1M7q
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Nov 2003 07:59:46 -0500
In-Reply-To: <3FC6BF5A.6050204@stesmi.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>, John Goerzen <jgoerzen@complete.org>
Cc: linux-ide@vger.kernel.org


My mistake, it should have been -Xudma5 :-).

On Friday 28 of November 2003 04:22, Stefan Smietanowski wrote:
> Hi John.
>
> >>>>Can you try setting drive to use UDMA100 instead of UDMA133
> >>>>(by something like 'hdparm -Xudma100 /dev/hda')?
> >
> > Tried that too, but I got:
> >
> > pi:~# hdparm -Xudma100 /dev/hde
> > -X: missing value
>
> Try -X69 (69 means udma100)
>
> Formula is simple. UDMA mode you want + 64, ie UDMA5 = 5+64.
>
> // Stefan

