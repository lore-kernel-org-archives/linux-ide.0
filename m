From: Dimitri Gorokhovik <dimitri.gorokhovik@free.fr>
Subject: [PATCH] ide: it821x in pass-through mode segfaults in 2.6.26-stable
Date: Mon, 14 Jul 2008 21:11:33 +0200
Message-ID: <20080714211133.514936a4@laphroaig>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757201AbYGNTgD@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

(Let me know if you need the kernel config for this.) 
---
The driver of ITE8212 in pass-through mode (it8212.noraid=1 on cmndline)
attempts to use the field `.dma_host_set' of the struct ide_dma_ops in
`ide_config_drive_speed' which is set to NULL by default.

So give a value to all fields of the struct ide_dma_ops.

---
diff --git a/drivers/ide/pci/it821x.c b/drivers/ide/pci/it821x.c
index 6ab0411..cbf6472 100644
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -512,8 +512,14 @@ static void __devinit it821x_quirkproc(ide_drive_t *drive)
 }
 
 static struct ide_dma_ops it821x_pass_through_dma_ops = {
+	.dma_host_set		= ide_dma_host_set,
+	.dma_setup		= ide_dma_setup,
+	.dma_exec_cmd		= ide_dma_exec_cmd,
 	.dma_start		= it821x_dma_start,
 	.dma_end		= it821x_dma_end,
+	.dma_test_irq		= ide_dma_test_irq,
+	.dma_timeout		= ide_dma_timeout,
+	.dma_lost_irq		= ide_dma_lost_irq,
 };
 
 /**
	
