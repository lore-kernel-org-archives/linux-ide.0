From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 9/15] cs5530: remove needless ide_lock taking
Date: Tue, 2 Oct 2007 14:45:41 +0100
Message-ID: <20071002144541.1832b74d@the-village.bc.nu>
References: <200710012337.16971.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49644 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751914AbXJBNkX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 09:40:23 -0400
In-Reply-To: <200710012337.16971.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

> -	spin_lock_irqsave(&ide_lock, flags);
> -		/* all CPUs (there should only be one CPU with this chipset) */
> -

NAK

What about pre-emptible kernels. Put in a private lock.

Alan
