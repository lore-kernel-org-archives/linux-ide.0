From: Mariusz Kozlowski <mk@lab.zgora.pl>
Subject: [PATCH] ide: fix use after free in ide-acpi
Date: Mon, 22 Nov 2010 20:34:38 +0100
Message-ID: <1290454478-5443-1-git-send-email-mk@lab.zgora.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mariusz Kozlowski <mk@lab.zgora.pl>
List-Id: linux-ide@vger.kernel.org

out_obj points to kfreed memory and we dereference that pointer in
DEBPRINT/printk.

Signed-off-by: Mariusz Kozlowski <mk@lab.zgora.pl>
---
 drivers/ide/ide-acpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index c26c119..2af8cb4 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -416,21 +416,21 @@ void ide_acpi_get_timing(ide_hwif_t *hwif)
 
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
-		kfree(output.pointer);
 		DEBPRINT("Run _GTM: error: "
 		       "expected object type of ACPI_TYPE_BUFFER, "
 		       "got 0x%x\n", out_obj->type);
+		kfree(output.pointer);
 		return;
 	}
 
 	if (!out_obj->buffer.length || !out_obj->buffer.pointer ||
 	    out_obj->buffer.length != sizeof(struct GTM_buffer)) {
-		kfree(output.pointer);
 		printk(KERN_ERR
 			"%s: unexpected _GTM length (0x%x)[should be 0x%zx] or "
 			"addr (0x%p)\n",
 			__func__, out_obj->buffer.length,
 			sizeof(struct GTM_buffer), out_obj->buffer.pointer);
+		kfree(output.pointer);
 		return;
 	}
 
-- 
1.7.0.4
