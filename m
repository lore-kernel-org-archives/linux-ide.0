From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Wed, 18 Nov 2009 18:41:25 +0000
Message-ID: <20091118184125.623e063d@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<20091117145137.15430.11229.stgit@localhost.localdomain>
	<200911181919.19127.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51539 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750905AbZKRSj3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 13:39:29 -0500
In-Reply-To: <200911181919.19127.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Maybe they are 'stable' but when it comes to features they are behind hpt366
> (i.e. they lack PCI PM), which is also much cleaner than your drivers, easier
> to understand and much smaller..

37x and 3xn lack PCI PM.  Added to the TODO list.

The smaller size is a bit questionable given its mostly comments, and
three drivers versus one.

> Having separate drivers wasn't the best decisions from the maintainability
> point-of-view.   It added needless complexity (different chips share the same

It was most definitely a good decision, having maintained both sets of
drivers at different times. It also makes it possible to do things the
way highpoint does rather than trying to make stuff common which HPT
themselves don't keep common. Even more importantly we get to break *one*
type of device at a time.

> PCI IDs which make detection across multiple drivers extremely painful) and
> confusion (i.e. would you have guessed that HPT302 is supported by pata_hpt37x
> while HPT302N by pata_hpt3x2n?).

I love highpoint too for their ever weirder and more confusingly labelled
and identified chips. I still think the split is worth it, and the 'wtf
device am I' logic is needed in both cases - either to pick a driver or
pick a set of methods.

We have the it821x driver for it8211/2 but not 8213 ..

Alan
