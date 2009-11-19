From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 19:42:13 +0000
Message-ID: <20091119194213.7f4dd425@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<4B0590A2.9050306@ru.mvista.com>
	<200911192003.09675.bzolnier@gmail.com>
	<200911192031.31613.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39030 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753946AbZKSTpm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 14:45:42 -0500
In-Reply-To: <200911192031.31613.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> In comparison to original patch the conversion from PCI access to
> io has been dropped as it is not required for the bugfix and makes
> patch easier for back-porting into -stable kernels.

Acked-by: Alan Cox <alan@linux.intel.com>

(and from what Sergey says about the 371N then the I/O conversion
is probably not needed anyway)
