From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] fix dma_unmap_sg misuse
Date: Thu, 19 Feb 2009 22:04:05 +0900
Message-ID: <20090219220401T.fujita.tomonori@lab.ntt.co.jp>
References: <20090217133432M.fujita.tomonori@lab.ntt.co.jp>
	<200902182159.49980.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:49710 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbZBSNEL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 08:04:11 -0500
In-Reply-To: <200902182159.49980.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux-ide@vger.kernel.org

On Wed, 18 Feb 2009 21:59:49 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Tuesday 17 February 2009, FUJITA Tomonori wrote:
> > Looks like that libata misuses dma_unmap_sg though I'm not familiar
> > with libata so I might completely misunderstand something.
> > 
> > =
> > From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > Subject: [PATCH] fix dma_unmap_sg misuse
> > 
> > DMA-mapping.txt says:
> > 
> > To unmap a scatterlist, just call:
> > 
> > 	pci_unmap_sg(pdev, sglist, nents, direction);
> > 
> > Again, make sure DMA activity has already finished.
> > 
> > PLEASE NOTE:  The 'nents' argument to the pci_unmap_sg call must be
> >               the _same_ one you passed into the pci_map_sg call,
> > 	      it should _NOT_ be the 'count' value _returned_ from the
> >               pci_map_sg call.
> 
> This is correct and other subsystems (SCSI, IDE) are compliant with it.
> 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Thanks,

I guess that the ide stack has the same problem (I guess that you
already knew that though).

Looks like that the ide stack in linux-next has more serious problem
about handling dma_map_sg?

In linux-next, the ide doesn't save the returned value of dma_map_sg
and assumes that dma_map_sg returns the same value to the 'nents'
argument of dma_map_sg?

Again I'm not familiar with the ide stack at all so I might completely
misunderstand something.

=
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Thu, 19 Feb 2009 21:51:17 +0900
Subject: [PATCH] ide: save the returned value of dma_map_sg

dma_map_sg could return a value different to 'nents' argument of
dma_map_sg so the ide stack needs to save it for the later usage
(e.g. for_each_sg).

The ide stack also needs to save the original sg_nents value for
pci_unmap_sg.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 drivers/ide/ide-dma.c |    6 +++++-
 include/linux/ide.h   |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index b4fa861..3dbf80c 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -143,6 +143,10 @@ int ide_build_sglist(ide_drive_t *drive, struct ide_cmd *cmd)
 	i = dma_map_sg(hwif->dev, sg, cmd->sg_nents, cmd->sg_dma_direction);
 	if (i == 0)
 		ide_map_sg(drive, cmd);
+	else {
+		cmd->orig_sg_nents = cmd->sg_nents;
+		cmd->sg_nents = i;
+	}
 
 	return i;
 }
@@ -163,7 +167,7 @@ void ide_destroy_dmatable(ide_drive_t *drive)
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_cmd *cmd = &hwif->cmd;
 
-	dma_unmap_sg(hwif->dev, hwif->sg_table, cmd->sg_nents,
+	dma_unmap_sg(hwif->dev, hwif->sg_table, cmd->orig_sg_nents,
 		     cmd->sg_dma_direction);
 }
 EXPORT_SYMBOL_GPL(ide_destroy_dmatable);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index c75631c..d3465d1 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -347,6 +347,7 @@ struct ide_cmd {
 	int			protocol;
 
 	int			sg_nents;	  /* number of sg entries */
+	int			orig_sg_nents;
 	int			sg_dma_direction; /* DMA transfer direction */
 
 	unsigned int		nbytes;
-- 
1.6.0.6

