From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 15/29] ide: flagged_taskfile() data byte order fix
Date: Wed, 2 Feb 2005 11:58:10 +0900
Message-ID: <20050202025810.GP621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> 15_ide_flagged_taskfile_data_byte_order_fix.patch
> 
> 	In flagged_taskfile(), when writing data register,
> 	taskfile->data goes to the lower byte and hobfile->data goes
> 	to the upper byte on little endian machines and the opposite
> 	happens on big endian machines.  This patch make
> 	taskfile->data always go to the lower byte regardless of
> 	endianess.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:03.518474705 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.093219204 +0900
@@ -823,7 +823,9 @@ ide_startstop_t flagged_taskfile (ide_dr
 
 	if (task->tf_out_flags.b.data) {
 		u16 data =  taskfile->data + (hobfile->data << 8);
-		hwif->OUTW(data, IDE_DATA_REG);
+		/* We want hobfile->data to go to the upper address,
+		   so the cpu_to_le16(). - tj */
+		hwif->OUTW(cpu_to_le16(data), IDE_DATA_REG);
 	}
 
 	/* (ks) send hob registers first */
