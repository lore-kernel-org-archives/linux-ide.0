From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules (linux 2.6.0)
Date: Tue, 6 Jan 2004 12:13:39 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200401061213.39843.bzolnier@elka.pw.edu.pl>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au> <200401051516.03364.bzolnier@elka.pw.edu.pl> <20040106135155.66535c13.davmac@ozonline.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51629 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261872AbUAFLKn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2004 06:10:43 -0500
In-Reply-To: <20040106135155.66535c13.davmac@ozonline.com.au>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Davin McCall <davmac@ozonline.com.au>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 06 of January 2004 03:51, Davin McCall wrote:
> Ok - fourth try! Hopefully I'm getting better.
>
> On Mon, 5 Jan 2004 15:16:03 +0100
>
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > You don't need to export "initializing" variable from ide.c,
> > just use "pre_init" variable from setup-pci.c :-).
>
> Yes - of course.
>
> But actually I have found an even better solution - "hwif->present" tells
> us if the hwif is currently being controlled by some chipset driver (that's
> what it's there for!) so I check that instead.

This is wrong, driver owns hwif before probing for drives
(when at least one drive is found hwif->present is set to one),
so hwif entries can be modified even with hwif->present equal to zero.

--bart

