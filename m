From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 16:35:41 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408171635.41282.bzolnier@elka.pw.edu.pl>
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171612.37898.bzolnier@elka.pw.edu.pl> <20040817141837.GA14738@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37251 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268248AbUHQOhW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2004 10:37:22 -0400
In-Reply-To: <20040817141837.GA14738@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Tuesday 17 August 2004 16:18, Alan Cox wrote:
> On Tue, Aug 17, 2004 at 04:12:37PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > this is dubious for many non PCI drivers which use ide_register_hw() to
> > only claim/fill ide_hwifs[] entry but actual probing is done later by
> > ide-generic driver - we end up with hwif->present == 0 and
> > hwif->configured == 1 and if ide_register_hw() will try to unregister
> > such hwif it will possibly crash (because we now check for ->configured
> > not ->present in
> > ide_unregister_hwif) - you've correctly noticed in the FIXMEs that we
>
> We check present as well as we free the various parts.  The problem we have
> is interfaces exist in "allocated by someone but not present" cases. Right
> now the lack of hotplug hides the fact this is totally broken. The
> unregister code tries to be smart about this and unregisters only certain
> bits of the object if its configured & !present. Thats why I save and use
> the present value on entry.

OK, I hope it is smart enough, will double check later.

> I've not looked at how it affects SCAN_HWIF but the other seemed ok.
>
> Alan
