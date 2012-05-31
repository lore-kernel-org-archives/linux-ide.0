From: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
Subject: [PATCH] ide: icside.c: fix printk format string compile warning
Date: Thu, 31 May 2012 12:08:09 +0200
Message-ID: <86hauw7jee.fsf_-_@gandalf.zerties.org>
References: <20120529103002.GA13283@faui49q.informatik.uni-erlangen.de>
	<4FC4C391.50700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FC4C391.50700@mvista.com> (Sergei Shtylyov's message of "Tue,
	29 May 2012 16:39:45 +0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, vamos-dev@lists.cs.fau.de
List-Id: linux-ide@vger.kernel.org

Peak datarate is never bigger than an integer, and can therefore, as
suggested in the printk format string, casted to an integer.
---
 drivers/ide/icside.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index 83e5100..755ef6b 100644
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -271,9 +271,9 @@ static void icside_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 
 	ide_set_drivedata(drive, (void *)cycle_time);
 
-	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
-		ide_xfer_verbose(xfer_mode),
-		2000 / (unsigned long)ide_get_drivedata(drive));
+	printk(KERN_INFO "%s: %s selected (peak %dMB/s)\n", drive->name,
+	       ide_xfer_verbose(xfer_mode),
+	       (int) (2000 / (unsigned long)ide_get_drivedata(drive)));
 }
 
 static const struct ide_port_ops icside_v6_port_ops = {
-- 
1.7.5.4
