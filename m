From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 07/12] libata: fix ata_acpi_gtm_xfermask()
Date: Tue, 6 Nov 2007 10:55:00 +0000
Message-ID: <20071106105500.759fd51f@the-village.bc.nu>
References: <1194327550227-git-send-email-htejun@gmail.com>
	<1194327551238-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50970 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755980AbXKFKyZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 05:54:25 -0500
In-Reply-To: <1194327551238-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Tue,  6 Nov 2007 14:39:05 +0900
Tejun Heo <htejun@gmail.com> wrote:

> ata_acpi_gtm_xfermask() as separated out from pacpi_discover_modes()
> has various bugs.  Fix them.
> 
> * The wrong comparison operator is used when finding for matching
>   cycle resulting totally bogus result.
> 
> * With the comparion operator fixed, boundary condtion handling is
>   clumsy.
> 
> * Setting of any DMA mask bit set all bits in PIO mask.
> 
> * MWDMA and UDMA blocks are swapped.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---

Looks good to me
