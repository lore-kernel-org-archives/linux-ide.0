From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: CMD649 hardware raid support
Date: Fri, 12 Sep 2003 18:41:05 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200309121841.05641.bzolnier@elka.pw.edu.pl>
References: <00bb01c37902$c299ca20$9700a8c0@eagle> <200309121450.38548.bzolnier@elka.pw.edu.pl> <007d01c3793e$2be09e60$9700a8c0@eagle>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63427 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261766AbTILQiu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2003 12:38:50 -0400
In-Reply-To: <007d01c3793e$2be09e60$9700a8c0@eagle>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-2?q?S=F6nke=20Ruempler?= <ruempler@topconcepts.com>
Cc: linux-ide@vger.kernel.org

On Friday 12 of September 2003 16:57, S=F6nke Ruempler wrote:
> > CMD649 *doesn't* have hardware RAID.
> > It is software RAID and kernels 2.4.x have basic support for it.
> > Alternatively you can use Linux's software RAID.
>
> Ok, but why can i define a raid array in the bios setup - i think THA=
T IS
> hardware raid?!

ROTFL ;-)
This is software RAID with RAID code in (card or motherboard) BIOS.

> And what do you mean with basic support? I mean, i can do software ra=
id
> with any device, so what do you mean with 'It is software RAID and ke=
rnels
> 2.4.x have basic support for it.' ?

CMD649 uses propertiary on disk RAID format.  2.4.x supports it.

> --
> Soenke

