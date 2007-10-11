From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_cs5536: ATA driver for Geode companion chip
Date: Thu, 11 Oct 2007 11:20:21 +0100
Message-ID: <20071011112021.3be68418@the-village.bc.nu>
References: <yq1y7eahzis.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43561 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755225AbXJKKP6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Oct 2007 06:15:58 -0400
In-Reply-To: <yq1y7eahzis.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, jordan.crouse@amd.com

On Thu, 11 Oct 2007 03:38:19 -0400
"Martin K. Petersen" <martin.petersen@oracle.com> wrote:

> 
> This is a driver for the ATA controller on the Geode CS5536 companion
> chip.  The PCI device ID for this device was previously claimed by
> pata_amd.c but the PIO timings were not correct.  This driver also
> works around a bug in some BIOSes that handle unaligned access to the
> PCI config registers poorly.  Finally, the driver allows fallback to
> using MSR registers for configuration on BIOSes that are truly
> broken.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Acked-by: Alan Cox <alan@redhat.com>
