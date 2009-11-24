From: Hemant Pedanekar <hemantp-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ide: fix ioctl to pass requested transfer mode to
	ide_find_dma_mode instead of UDMA6
Date: Tue, 24 Nov 2009 09:46:28 +0530
Message-ID: <1259036188-11598-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, petkovbb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, christian.engelmayer-USXAA5bZaHGDvotElmWtJA@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Currently, ide_cmd_ioctl when invoked for setting DMA transfer mode calls
ide_find_dma_mode with requested mode as XFER_UDMA_6. This prevents setting DMA
mode to any other value than the default (maximum) supported by the device (or
UDMA6, if supported) irrespective of the actual requested transfer mode and
returns error.

For example, setting mode to UDMA2 using hdparm, where UDMA4 is the default
transfer mode gives following error:
	# ./hdparm -d1 -Xudma2  /dev/hda
	 /dev/hda:hda: UDMA/66 mode selected
	 setting using_dma to 1 (on)
	 hda: UDMA/66 mode selected
	 setting xfermode to 66 (UltraDMA mode2)
	 HDIO_DRIVE_CMD(setxfermode) failed: Invalid argument
	 using_dma     =  1 (on)

This patch fixes the issue.

Signed-off-by: Hemant Pedanekar <hemantp-l0cyMroinI0@public.gmane.org>
Acked-by: Bartlomiej Zolnierkiewicz <bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/ide/ide-ioctls.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index d3440b5..6e7ae2b 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -162,7 +162,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 	if (tf->command == ATA_CMD_SET_FEATURES &&
 	    tf->feature == SETFEATURES_XFER &&
 	    tf->nsect >= XFER_SW_DMA_0) {
-		xfer_rate = ide_find_dma_mode(drive, XFER_UDMA_6);
+		xfer_rate = ide_find_dma_mode(drive, tf->nsect);
 		if (xfer_rate != tf->nsect) {
 			err = -EINVAL;
 			goto abort;
-- 
1.6.2.4
