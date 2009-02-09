From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for February 9 (ide-dma)
Date: Mon, 09 Feb 2009 13:50:20 -0800
Message-ID: <4990A51C.1090607@oracle.com>
References: <20090209193908.1a448944.sfr@canb.auug.org.au> <499064CC.1030907@oracle.com> <200902091956.54226.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200902091956.54226.bzolnier@gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Monday 09 February 2009, Randy Dunlap wrote:
>> Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> [I accidentally deleted the merge and quilt-import logs today :-( - I
>>> wonder if any would have noticed :-).  The merge summary still appears
>>> below.]
>>>
>>> Changes since 20090206:
>>>
>>> New tree:
>>> 	aoe
>>>
>>> Undropped trees:
>>> 	ide
>>
>> When CONFIG_BLK_DEV_IDEDMA=n:
>>
>> drivers/ide/ide-taskfile.c:104: error: implicit declaration of function 'ide_build_sglist'
> 
> Thanks.  Should be fixed with new revision of the guilty patch
> (fix part is in <linux/ide.h> chunk):

Ack.  That works.  Thanks.

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: call ide_build_sglist() prior to ->dma_setup (v2)
> 
> * Re-map sg table if needed in ide_build_sglist().
> 
> * Move ide_build_sglist() call from ->dma_setup to its users.
> 
> * Un-export ide_build_sglist().
> 
> v2:
> * Build fix for CONFIG_BLK_DEV_IDEDMA=n (noticed by Randy Dunlap).
> 
> There should be no functional changes caused by this patch.
> 
> Cc: Randy Dunlap <randy.dunlap@oracle.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -1474,6 +1474,8 @@ static inline int ide_set_dma(ide_drive_
>  static inline void ide_check_dma_crc(ide_drive_t *drive) { ; }
>  static inline ide_startstop_t ide_dma_timeout_retry(ide_drive_t *drive, int error) { return ide_stopped; }
>  static inline void ide_release_dma_engine(ide_hwif_t *hwif) { ; }
> +static inline int ide_build_sglist(ide_drive_t *drive,
> +				   struct request *rq) { return 0; }
>  #endif /* CONFIG_BLK_DEV_IDEDMA */
>  
>  #ifdef CONFIG_BLK_DEV_IDEACPI
> 
> 
> 
> 


-- 
~Randy
