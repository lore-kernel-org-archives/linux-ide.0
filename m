From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 20:54:32 +0100
Message-ID: <200911192054.32533.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911192031.31613.bzolnier@gmail.com> <20091119194213.7f4dd425@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:58466 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbZKSTzl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 14:55:41 -0500
In-Reply-To: <20091119194213.7f4dd425@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Thursday 19 November 2009 20:42:13 Alan Cox wrote:
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > In comparison to original patch the conversion from PCI access to
> > io has been dropped as it is not required for the bugfix and makes
> > patch easier for back-porting into -stable kernels.
> 
> Acked-by: Alan Cox <alan@linux.intel.com>
> 
> (and from what Sergey says about the 371N then the I/O conversion
> is probably not needed anyway)

Thanks, I'll re-sync other pata_hpt37x patches on top of this one later.

ps if you could also push the fix to hpt366.c it would be great

-- 
Bartlomiej Zolnierkiewicz
