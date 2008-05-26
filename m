From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC: 2.6 patch] remove BLK_DEV_HD_ONLY
Date: Mon, 26 May 2008 20:50:21 +0100
Message-ID: <20080526205021.12ef7948@core>
References: <20080519215357.GH17716@cs181133002.pp.htv.fi>
	<20080519225018.1df63bef@core>
	<200805272114.12763.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58165 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754561AbYEZUDu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 May 2008 16:03:50 -0400
In-Reply-To: <200805272114.12763.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org

> I tend to disagree:
> 
> - there is nothing wrong with using an older kernel for rescue operations
>   on MFM/RLL drives

Older kernels don't boot on a lot of modern hardware.

> - it should be relatively easy to add MFM/RLL support to IDE subsystem
>   or libata layer (or even both)

I'm working on a libata driver when I get bits of time but it is not
trivial because stuff like device probe is totally different,
multi-write/multi-read are different, some of the command set is
different and even some of the task file registers are different.

> If there is no consensus about hd.c removal I think that the appropriate
> alternative would be to move it to drivers/block/ as it has nothing to do
> with IDE subsystem code.

Thats true enough.

Alan
