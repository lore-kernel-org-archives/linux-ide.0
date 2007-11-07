From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] libata: pata_platform: Support polling-mode
 configuration.
Date: Wed, 7 Nov 2007 13:10:36 +0000
Message-ID: <20071107131036.184e1c73@the-village.bc.nu>
References: <20071107081052.GA25913@linux-sh.org>
	<20071107081119.GB25913@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50439 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758011AbXKGNKa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 08:10:30 -0500
In-Reply-To: <20071107081119.GB25913@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net

> +	 * Use polling mode if there's no IRQ
> +	 */
> +	if (irq < 0) {
> +		ap->flags |= ATA_FLAG_PIO_POLLING;
> +		ata_port_desc(ap, "no IRQ, using PIO polling");
> +	}
> +
> +	/*

Zero means no IRQ. Not < 0. We enforce that policy across the kernel and
Linus has been very clear about it.

