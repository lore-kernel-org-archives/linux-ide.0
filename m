From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: to /sys from /proc/ide/hd$v/identify
Date: Mon, 7 Jun 2004 21:54:33 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406072154.33609.bzolnier@elka.pw.edu.pl>
References: <1086616121.3649.0.camel@patibmrh9> <40C4739C.6070508@pobox.com> <4D5B0986-B8BB-11D8-AE55-00039398BB5E@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40935 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265025AbUFGTuw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jun 2004 15:50:52 -0400
In-Reply-To: <4D5B0986-B8BB-11D8-AE55-00039398BB5E@ieee.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Monday 07 of June 2004 21:46, Pat LaVarre wrote:
> >>> - /proc/ide/ interfaces are obsolete
> >>
> >> Where do I now find the ATA op xEC/A1 "IDENTIFY" data that was
> >> /proc/ide/hd$v/identify ?
> >
> > Since IDE supports taskfile ioctl, you shouldn't need this in sysfs...

There is also HDIO_GET_IDENTITY.

