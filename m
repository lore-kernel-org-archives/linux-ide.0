From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for February 12 (ide)
Date: Wed, 18 Feb 2009 09:17:28 -0800
Message-ID: <499C42A8.7060003@oracle.com>
References: <20090212194408.ff7489c1.sfr@canb.auug.org.au> <499451E0.6060004@oracle.com> <200902171519.27031.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200902171519.27031.bzolnier@gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Thursday 12 February 2009, Randy Dunlap wrote:
>> Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20090211:
>>
>> When
>> # CONFIG_BLK_DEV_IDEDMA is not set
>>
>> linux-next-20090212/drivers/ide/ide-taskfile.c:108: error: 'ide_dma_intr' undeclared (first use in this function)
> 
> Thanks for spotting this, I fixed it in the revised patch:

Hi Bart,

Have you pushed this patch yet?

linux-next (20090218) is still getting this IDE build error.

Thanks.

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: add ->dma_timer_expiry method and remove ->dma_exec_cmd one (v2)
> 
> * Rename dma_timer_expiry() to ide_dma_sff_timer_expiry() and export it.
> 
> * Add ->dma_timer_expiry method and use it to set hwif->expiry for
>   ATA_PROT_DMA protocol in do_rw_taskfile().
> 
> * Initialize ->dma_timer_expiry to ide_dma_sff_timer_expiry() for SFF hosts.
> 
> * Move setting hwif->expiry from ide_execute_command() to its users and drop
>   'expiry' argument.
> 
> * Use ide_execute_command() instead of ->dma_exec_cmd in do_rw_taskfile().
> 
> * Remove ->dma_exec_cmd method and its implementations.
> 
> * Unexport ide_execute_command() and ide_dma_intr().
> 
> v2:
> * Fix CONFIG_BLK_DEV_IDEDMA=n build (noticed by Randy Dunlap).
> 
> * Fix *dma_expiry naming (suggested by Sergei Shtylyov).
> 
> There should be no functional changes caused by this patch.
> 
> Cc: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/alim15x3.c     |    2 +-
>  drivers/ide/au1xxx-ide.c   |    8 --------
>  drivers/ide/cmd64x.c       |    6 +++---
>  drivers/ide/cs5536.c       |    2 +-
>  drivers/ide/hpt366.c       |    6 +++---
>  drivers/ide/icside.c       |    7 -------
>  drivers/ide/ide-atapi.c    |    3 ++-
>  drivers/ide/ide-dma-sff.c  |   15 ++++-----------
>  drivers/ide/ide-dma.c      |    1 -
>  drivers/ide/ide-iops.c     |    6 +-----
>  drivers/ide/ide-taskfile.c |    6 ++++--
>  drivers/ide/it821x.c       |    2 +-
>  drivers/ide/ns87415.c      |    2 +-
>  drivers/ide/pdc202xx_old.c |    4 ++--
>  drivers/ide/pmac.c         |    8 --------
>  drivers/ide/sc1200.c       |    2 +-
>  drivers/ide/scc_pata.c     |    2 +-
>  drivers/ide/siimage.c      |    2 +-
>  drivers/ide/sl82c105.c     |    2 +-
>  drivers/ide/tc86c001.c     |    2 +-
>  drivers/ide/trm290.c       |    6 ------
>  drivers/ide/tx4939ide.c    |    2 +-
>  include/linux/ide.h        |    8 ++++----
>  23 files changed, 33 insertions(+), 71 deletions(-)


-- 
~Randy
