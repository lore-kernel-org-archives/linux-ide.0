From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Fix ata_id_has_dword_io to return DWORD I/O support properly
Date: Fri, 19 Dec 2008 20:30:34 +0100
Message-ID: <200812192030.34554.bzolnier@gmail.com>
References: <494A5BBF.8000807@inf.tu-dresden.de> <200812190013.10156.bzolnier@gmail.com> <20081219105013.0e43c364@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:57750 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbYLSTbJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Dec 2008 14:31:09 -0500
In-Reply-To: <20081219105013.0e43c364@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, Mario Schwalbe <schwalbe@inf.tu-dresden.de>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Friday 19 December 2008, Alan Cox wrote:
> > Sure, we can always improve things further later.  However Mario's patch
> > is _definitely_ an improvement over the _current_ code.  Don't you agree?
> 
> No actually I don't. The current head dev code checks ATA > 7 as the
> indicator that this bit is used for treacherous computing. That means the
> behaviour for all the older drives is clearly back compatible with old
> Linux behaviour.
> 
> Doing it that way around means we don't have any worries about changing
> existing behaviours.

Please try to verify old Linux behaviour compatiblity statement with
some ATA-[2..7] devices...  They have old ATA-1 bit set to _zero_...

Mario: I don't have anymore time to spend on fixing libata problems so
I'll be leaving ata_id_has_dword_io() issues up to libata maintainers,
sorry for inconvenience!

Thanks,
Bart
