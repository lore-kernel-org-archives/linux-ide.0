From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Fri, 28 Nov 2003 00:16:48 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200311280016.48828.bzolnier@elka.pw.edu.pl>
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <200311272042.19568.bzolnier@elka.pw.edu.pl> <20031127225508.GA5926@complete.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10918 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261606AbTK0XPk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Nov 2003 18:15:40 -0500
In-Reply-To: <20031127225508.GA5926@complete.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-ide@vger.kernel.org


Can you first try booting with "ide2=autodma" kernel parameter
instead of downgrading to UDMA100?

--bart

On Thursday 27 of November 2003 23:55, John Goerzen wrote:
> On Thu, Nov 27, 2003 at 08:42:19PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > [ linux-kernel@ replaced by linux-ide@ ]
>
> OK (please continue to CC me on replies)
>
> > Can you try setting drive to use UDMA100 instead of UDMA133
> > (by something like 'hdparm -Xudma100 /dev/hda')?
>
> I will give it a whirl and see if I can repeat the problem and let you
> know.
>
> > Also please send full dmesg and config.
>
> Attached.

