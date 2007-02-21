From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Wed, 21 Feb 2007 03:42:20 +0100
Message-ID: <200702210342.20775.bzolnier@gmail.com>
References: <20070221011922.GA1777@freefall.freebsd.org> <200702210244.53514.bzolnier@gmail.com> <3063A690-4E3D-4A6E-A7DC-3E624121FBB8@freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:13467 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932317AbXBUCgO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 21:36:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so954138uga
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 18:36:13 -0800 (PST)
In-Reply-To: <3063A690-4E3D-4A6E-A7DC-3E624121FBB8@freebsd.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Wednesday 21 February 2007 03:13, Suleiman Souhlal wrote:
> 
> On Feb 20, 2007, at 5:44 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> >
> > On Wednesday 21 February 2007 02:19, Suleiman Souhlal wrote:
> >> It can be changed via /proc/ide/hd?/settings.
> >
> > Why do we need to change IDE DMA timeout dynamically?
> 
> I've used it to test error recovery (for example).

Seems quite useable for developers but I would prefer not to
expose it in production kernels for end users.

> > BTW /proc/ide/hd?/settings is obsoleted
> 
> What's the preferred way of changing such settings, these days?

sysfs

ide.c:ide_dev_attrs[] for generic attributes valid for all devices

Thanks,
Bart
