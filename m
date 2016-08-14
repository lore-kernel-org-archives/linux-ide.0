From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 17:09:05 +0100
Message-ID: <20160814170905.485fbb24@lxorguk.ukuu.org.uk>
References: <20160813190340.GA29989@amd>
	<20160814092044.GA20392@amd>
	<CAGnHSEmtgGO5QjfamnN0VPOO2w-4GrZQvPnbkBVdtWBPTnLieA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48890 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbcHNQJm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Aug 2016 12:09:42 -0400
In-Reply-To: <CAGnHSEmtgGO5QjfamnN0VPOO2w-4GrZQvPnbkBVdtWBPTnLieA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, jamespharvey20@gmail.com, regressions@leemhuis.info, hdegoede@redhat.com, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, stern@rowland.harvard.edu

On Sun, 14 Aug 2016 17:34:18 +0800
Tom Yan <tom.ty89@gmail.com> wrote:

> Since when it is expected that SATA disks will always be probed before
> USB disks? We can't guarantee that even if we make sure all ata
> drivers are loaded before usb-storage/uas. That's why we need
> consistent namings (e.g. /dev/disk/by-id/*).

It hasn't. It isn't even true on older kernels and can depend on all
sorts of things. I have boxes that will put the USB first, and a 10
second google search says I'm not alone

http://serverfault.com/questions/322946/ensure-usb-disk-is-never-sda-even-when-booting-from-it

So your "regression" goes back to at least 2011.

Alan
