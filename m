From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/4] ide: constify struct ide_dma_ops
Date: Sun, 09 Mar 2008 20:01:17 +0300
Message-ID: <47D417DD.20404@ru.mvista.com>
References: <200803091702.18521.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:36188 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750997AbYCIRAD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Mar 2008 13:00:03 -0400
In-Reply-To: <200803091702.18521.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Export ide_dma_exec_cmd() and __ide_dma_test_irq().

> * Constify struct ide_dma_ops.

> * Always set hwif->dma_ops to &sff_dma_ops in ide_setup_dma()
>   (it is later overriden by ide_init_port() if needed) and drop
>   'const struct ide_port_info *d' argument.

> While at it:

> * Rename __ide_dma_test_irq() to __ide_dma_test_irq().

    Huh? :-)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

MBR, Sergei
