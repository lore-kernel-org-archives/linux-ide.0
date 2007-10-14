From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_cs5536: ATA driver for Geode companion chip
Date: Sun, 14 Oct 2007 20:51:03 +0100
Message-ID: <20071014205103.177bd08d@the-village.bc.nu>
References: <yq1y7eahzis.fsf@sermon.lab.mkp.net>
	<20071011112021.3be68418@the-village.bc.nu>
	<76366b180710132149i7dabb3dcv21abaafd5814a923@mail.gmail.com>
	<76366b180710141242w5ff89d9ej9cfdc1a5904639e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38791 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754514AbXJNTrP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Oct 2007 15:47:15 -0400
In-Reply-To: <76366b180710141242w5ff89d9ej9cfdc1a5904639e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew.m.paprocki@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, jordan.crouse@amd.com

On Sun, 14 Oct 2007 15:42:19 -0400
"Andrew Paprocki" <andrew.m.paprocki@gmail.com> wrote:

> Just noticed something.. I'm not sure if this is due to a libata-dev
> change or me switching to pata_cs5536, but my 128MB DOM on the PATA
> port is hitting the ata_dma_blacklisted() case and it was not
> previously. This did not happen under 2.6.22.6 using pata_amd. The
> system is noticeably slower when forced to use PIO4 (as you would
> expect).
> 
> Is this expected in the newer code, or is it a bug?

Sounds like someone added it wrongly to the blacklist. Remove the
blacklist entry, test again and if DMA is working we need to get that
fixed ASAP in .2 and 2.6.24.

Alan
