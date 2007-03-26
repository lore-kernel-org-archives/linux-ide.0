From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/15] ide: make ide_hwif_t.ide_dma_host_on void
Date: Mon, 26 Mar 2007 21:19:36 +0400
Message-ID: <460800A8.4050501@ru.mvista.com>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain> <20070119003220.14846.14258.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:47647 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753277AbXCZRS4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Mar 2007 13:18:56 -0400
In-Reply-To: <20070119003220.14846.14258.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: make ide_hwif_t.ide_dma_host_on void

> * since ide_hwif_t.ide_dma_host_on is called either when drive->using_dma == 1
>   or when return value is discarded make it void, also drop "ide_" prefix
> * make __ide_dma_host_on() void and drop "__" prefix

    BTW, it would also make sense to make hwif->ide_dma_timeout() and 
hwif->ide_dma_lostirq void too (and possibly drop the ide_ prefix). Their 
results are *explicitly* ignored.

MBR, Sergei
