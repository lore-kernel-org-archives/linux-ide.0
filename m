From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 11/15] ide: PCI BMDMA initialization fixes
Date: Wed, 24 Oct 2007 21:37:44 +0400
Message-ID: <471F82E8.2010907@ru.mvista.com>
References: <200710012338.31404.bzolnier@gmail.com> <47039571.20907@ru.mvista.com> <200710032359.32630.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33775 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756898AbXJXRhg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Oct 2007 13:37:36 -0400
In-Reply-To: <200710032359.32630.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] ide: PCI BMDMA initialization fixes (take 2)

> * Set hwif->dma_base only if allocation of extra ports succeeds.

> While at it:

> * Move setting of hwif->dma_{base,master} from ide_{mapped_mmio,iomio}_dma()
>   to ide_setup_dma().

> * Rename 'dma_base' argument to 'base' in ide_setup_dma() (to make the code
>   obey 80-columns limit and increase its readability).

> * Remove stale ide_setup_dma() comment.

> v2:
> * Change to allocate hwif->dmatable_cpu before reserving I/O ports missed
>   teardown code (spotted by Sergei).  On the second thought this change is
>   actually unnecessary so revert it in v2.

> * Make ide_release_dma_engine() void and remove needless comment.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
