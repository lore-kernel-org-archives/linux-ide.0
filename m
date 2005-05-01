From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] drivers/ide/: possible cleanups
Date: Sun, 01 May 2005 14:37:43 +0100
Message-ID: <1114954660.11309.154.camel@localhost.localdomain>
References: <20050430200750.GM3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:19427 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261514AbVEANlF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 May 2005 09:41:05 -0400
In-Reply-To: <20050430200750.GM3571@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Sad, 2005-04-30 at 21:07, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - pci/cy82c693.c: make a needlessly global function static
> - remove the following unneeded EXPORT_SYMBOL's:
>   - ide-taskfile.c: do_rw_taskfile
>   - ide-iops.c: default_hwif_iops
>   - ide-iops.c: default_hwif_transport
>   - ide-iops.c: wait_for_ready

default_*_ops are very much API items not currently used. You need them
if you
want to switch from mmio back to pio (eg doing S3 resume) although
nobody is currently doing that.

wait_for_ready used to be used by ide-probe as a module so seems sane.


