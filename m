From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: fix ioctl to pass requested transfer mode to
 ide_find_dma_mode instead of UDMA6
Date: Wed, 25 Nov 2009 15:05:12 -0800 (PST)
Message-ID: <20091125.150512.103371946.davem@davemloft.net>
References: <1259063450-21049-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49574
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758902AbZKYXEy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 18:04:54 -0500
In-Reply-To: <1259063450-21049-1-git-send-email-hemantp@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hemantp@ti.com
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, sshtylyov@ru.mvista.com, petkovbb@gmail.com, christian.engelmayer@frequentis.com, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

From: Hemant Pedanekar <hemantp@ti.com>
Date: Tue, 24 Nov 2009 17:20:50 +0530

> Currently, ide_cmd_ioctl when invoked for setting DMA transfer mode calls
> ide_find_dma_mode with requested mode as XFER_UDMA_6. This prevents setting DMA
> mode to any other value than the default (maximum) supported by the device (or
> UDMA6, if supported) irrespective of the actual requested transfer mode and
> returns error.
> 
> For example, setting mode to UDMA2 using hdparm, where UDMA4 is the default
> transfer mode gives following error:
> 	# ./hdparm -d1 -Xudma2  /dev/hda
> 	 /dev/hda:hda: UDMA/66 mode selected
> 	 setting using_dma to 1 (on)
> 	 hda: UDMA/66 mode selected
> 	 setting xfermode to 66 (UltraDMA mode2)
> 	 HDIO_DRIVE_CMD(setxfermode) failed: Invalid argument
> 	 using_dma     =  1 (on)
> 
> This patch fixes the issue.
> 
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Applied and queued up for -stable, thanks!
