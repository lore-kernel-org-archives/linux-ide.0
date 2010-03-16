From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 15:25:58 +0100
Message-ID: <201003161525.59364.arnd@arndb.de>
References: <4B947393.2050002@kernel.org> <4B9F8E1A.2020608@kernel.org> <1268749297.21384.15.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59227 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab0CPO0s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Mar 2010 10:26:48 -0400
In-Reply-To: <1268749297.21384.15.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Tejun Heo <tj@kernel.org>, Denys Vlasenko <vda.linux@googlemail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

On Tuesday 16 March 2010, James Bottomley wrote:
> On Tue, 2010-03-16 at 22:56 +0900, Tejun Heo wrote:
> > Hello, James.
> > 
> > On 03/16/2010 10:24 PM, James Bottomley wrote:
> > > For msdos labels, it's embedded in the label ... for all other labels,
> > > it's made up on the spot.
> > 
> > Where in the label?
> 
> No idea ... I only know you can use fdisk expert mode to change the
> C/H/S layout and the change is preserved across reboots.

IIRC, the layout is guessed from the partition end locations, in the
assumption that each partition is aligned to full cylinders. That
gives you the heads/sectors number, while the cylinder number can be
calculated from the total number of sectors using these numbers.

	Arnd
