From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Date: Tue, 17 Aug 2004 01:22:29 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408170122.29669.bzolnier@elka.pw.edu.pl>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408161724.09880.bzolnier@elka.pw.edu.pl> <20040816153011.GE10279@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:932 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268020AbUHPXXG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 19:23:06 -0400
In-Reply-To: <20040816153011.GE10279@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Monday 16 August 2004 17:30, Alan Cox wrote:
> On Mon, Aug 16, 2004 at 05:24:09PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > This patch removes write access to /proc/ide/hd?/driver without even
> > mentioning this - IMHO we should deprecate it first.  Such changes should
> > be described (with rationale for them) at least in the changelog
> > (or even better in Documentation/ide.txt).
>
> I thought we discussed this earlier - its essentially unfixable. You can
> either have trivial /proc crashes, deadlocks on writing this file or lose
> the feature (which nobody on the planet even knew about).

I used this 'feature' few times and never experienced crash or deadlock
but they are possible of course.

> If you've got any ideas how to fix it then let me know.
>
> Agreed about adding it to Documentation/ide.txt

I fully agreed on the change but not the way in which it's done. ;-)
