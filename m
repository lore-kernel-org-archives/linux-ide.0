From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 18:07:40 +0800
Message-ID: <CAGnHSEm-Gww1-bmqZMz6guFDnByUuCFiCLhdrK_LETBH3qcb1Q@mail.gmail.com>
References: <20160813190340.GA29989@amd> <20160814092044.GA20392@amd>
 <CAGnHSEmtgGO5QjfamnN0VPOO2w-4GrZQvPnbkBVdtWBPTnLieA@mail.gmail.com> <20160814100102.GA31847@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34485 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbcHNKHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Aug 2016 06:07:42 -0400
In-Reply-To: <20160814100102.GA31847@amd>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, james harvey <jamespharvey20@gmail.com>, regressions@leemhuis.info, hdegoede@redhat.com, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>

On 14 August 2016 at 18:01, Pavel Machek <pavel@ucw.cz> wrote:
>
> Since SATA support was merged, certainly since v2.4, and from way
> before /dev/disk/by-id existed.

I have no idea how "SATA before USB" had been done in the past (if it
was ever a thing in the kernel), but that has not been the case since
at least v3.0 AFAIR.

>
> People may not run udev, and you can't use /dev/disk/by-id on kernel
> command line.
>

No, but you can always use root=PARTUUID=, that's built into the
kernel. (root=UUID= requires udev or so though).
