From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/13] ide: add IDE_HFLAG_LEGACY_IRQS host flag
Date: Wed, 10 Oct 2007 00:20:24 +0400
Message-ID: <470BE288.7090201@ru.mvista.com>
References: <200709052354.03098.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30076 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751866AbXJIUUq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 16:20:46 -0400
In-Reply-To: <200709052354.03098.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Add IDE_HFLAG_LEGACY_IRQS host flag to tell ide_pci_setup_ports() to set
> hwif->irq to legacy IRQ 14/15 (iff hwif->irq is not already set) and convert
> atiixp, piix, serverworks, sis5513 and slc90e66 host drivers to use it.

> While at it:

> * In piix.c add IDE_HFLAGS_PIIX define and don't use ->init_hwif for MPIIX.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
