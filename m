From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 17:05:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408171705.43974.bzolnier@elka.pw.edu.pl>
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171630.07979.bzolnier@elka.pw.edu.pl> <20040817144604.GA30778@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64903 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268281AbUHQPGk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2004 11:06:40 -0400
In-Reply-To: <20040817144604.GA30778@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Tuesday 17 August 2004 16:46, Alan Cox wrote:
> > ide_match_hwif() checks for hwif->chipset - ordering will not be the same
> > i.e. you load driver for some IDE PCI controller which doesn't have
> > drives attached to it, unload it, load some other driver - hwifs will be
> > reused - some sequence in 2.4 will possibly leave you with different
> > ordering because hwif->chipset will stay as ide_pci not ide_unknown
>
> You can't unload them in 2.4.

Really?  That would simplify a lot of considerations...

> > Yep, please tell me how are you going to support drive hot plug?
>
> We can do it the 2.4-ac way - that works with the locking I think. What

if you are talking about abusing HDIO_SCAN_HWIF then HELL NO

> might be nicer if it works out is to follow the shutdown/suspend code
> approach so that we actually queue the "unplug" into the command stream.

and we are back to lack of sysfs integration
