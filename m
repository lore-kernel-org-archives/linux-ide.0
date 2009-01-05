From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 18:15:24 +0100
Message-ID: <200901051815.24847.bzolnier@gmail.com>
References: <49615667.9020408@iwl.com> <200901051736.18026.bzolnier@gmail.com> <20090105165238.616e5186@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:58815 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbZAERO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 12:14:59 -0500
Received: by bwz14 with SMTP id 14so22890145bwz.13
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2009 09:14:56 -0800 (PST)
In-Reply-To: <20090105165238.616e5186@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>

On Monday 05 January 2009, Alan Cox wrote:
> > * CS5536 is used mostly for driving CF cards and this allows use of
> >   IDE features which are unavailable under libata (32-bit I/O support,
> >   non-rotational media optimizations, etc).
> 
> Non rotational media handling is done by the block layer and so works for
> everything. Just set the right queue according to the device policy you
> want in hal/udev.

You seem to confuse no merges policy with non rotational media support.

Both are done by block layer.  The former is controlled by the user-space
while the latter is controlled by the block driver.

Thanks,
Bart
