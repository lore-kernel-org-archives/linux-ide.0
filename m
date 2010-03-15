From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 15 Mar 2010 13:30:45 +0100
Message-ID: <201003151330.45474.arnd@arndb.de>
References: <4B947393.2050002@kernel.org> <201003150326.22262.vda.linux@googlemail.com> <4B9DB0F2.7060808@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49673 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab0COMbd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Mar 2010 08:31:33 -0400
In-Reply-To: <4B9DB0F2.7060808@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

On Monday 15 March 2010, H. Peter Anvin wrote:
> > 256K alignment is hard to swallow for a lot of reasons anyway.
> > Unless the filesystem packs small files into blocks a-la reiserfs,
> > 256K block filesystems will be very inefficient for a typical
> > storage scenarios.
>
> Noone has talked about using 256K filesystem blocks.

Well, logfs has just been merged and works with block sizes in that
range, but obviously only if the partition is correctly aligned.

	Arnd
