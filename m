From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/15] ATA : vortex86 : fix vortex86dx/sx hardware CRC
 bug.
Date: Thu, 27 Oct 2011 08:43:10 +0100
Message-ID: <20111027084310.2b7da753@pyx>
References: <fix vortex86>
	<1319602564-19162-1-git-send-email-paul.s.schilling@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [85.13.70.251] ([85.13.70.251]:63672 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752353Ab1J0Hxg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2011 03:53:36 -0400
In-Reply-To: <1319602564-19162-1-git-send-email-paul.s.schilling@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Schilling <paul.s.schilling@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

On Tue, 25 Oct 2011 23:16:04 -0500
Paul Schilling <paul.s.schilling@gmail.com> wrote:

> This fixes a DMA issue related to a CRC bug on
> the RDC pata peripherial found on the vortex86sx and vortex86dx.

What is the RDC erratum reference for this ? Also it seems to make no
sense


>  	static const struct ata_port_info info_rdc_11 = {
>  		.flags = ATA_FLAG_SLAVE_POSS,
>  		.pio_mask = ATA_PIO4,
> -		.mwdma_mask = ATA_MWDMA2,
> +		.mwdma_mask = 0,
> +		.udma_mask = 0,

MWDMA is not part of the CRC hardware anyway

Are you sure these newer variants are simply not using a different set of
timing parameters thus showing bugs on your system ?
