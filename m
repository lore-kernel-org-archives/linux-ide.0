From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] scc_pata: dependency fix
Date: Sat, 17 Mar 2007 21:50:10 +0100
Message-ID: <200703172150.11143.bzolnier@gmail.com>
References: <200703160203.l2G23QgI022196@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38868 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbXCQVBq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 17:01:46 -0400
Received: by ug-out-1314.google.com with SMTP id 44so986750uga
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 14:01:45 -0700 (PDT)
In-Reply-To: <200703160203.l2G23QgI022196@toshiba.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: torvalds@linux-foundation.org, Al Viro <viro@ftp.linux.org.uk>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Friday 16 March 2007, Akira Iguchi wrote:
> This patch fixes:
> * the dependency of scc_pata on BLK_DEV_IDEDMA_PCI
> * incorrect link to ide-core
> * move scc_pata from ide/ppc to ide/pci
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

I applied both patches after:

* manually fixing the reject in drivers/ide/Kconfig
  (because Al's "IDE=y" fix has already been applied)

* merging patch #1 and #2 into a single one
  (otherwise patch #1 alone breaks kernel build)

Thanks,
Bart
