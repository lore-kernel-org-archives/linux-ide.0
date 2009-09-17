From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_amd: do not filter out valid modes in nv_mode_filter
Date: Thu, 17 Sep 2009 16:51:49 -0400
Message-ID: <4AB2A165.7080507@garzik.org>
References: <4AAC8927.4030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54722 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577AbZIQUvt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 16:51:49 -0400
In-Reply-To: <4AAC8927.4030401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, stable@kernel.org

On 09/13/2009 01:54 AM, Robert Hancock wrote:
> On a Compaq Presario V3000 laptop (NVIDIA MCP51 chipset), pata_amd selects
> PIO0 mode for the PATA DVD-RAM drive instead of MWDMA2 which it supports:
>
> ata4.00: ATAPI: HL-DT-ST DVDRAM GSA-4084N, KQ09, max MWDMA2
> ata4: nv_mode_filter: 0x39f&0x7001->0x1, BIOS=0x0 (0x0) ACPI=0x7001 (60:600:0x11)
> ata4.00: configured for PIO0
>
> For some reason, the BIOS-set UDMA configuration returns 0 and the ACPI _GTM
> reports that UDMA2 and PIO0 are enabled. This causes nv_mode_filter to end up
> allowing only PIO0 and UDMA0-2. Since the drive doesn't support UDMA we end up
> using PIO0.
>
> Since the controllers should always support PIO4, MWDMA2 and UDMA2 regardless
> of what cable type is used, let's make sure we don't filter out these modes
> regardless of what wacky settings the BIOS is using.
>
> Signed-off-by: Robert Hancock<hancockrwd@gmail.com>
> Cc: stable@kernel.org

applied


