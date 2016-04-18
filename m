From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 5/5] cmd640: add __init attribute
Date: Mon, 18 Apr 2016 16:55:38 +0200
Message-ID: <1460991338-9845-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1460991338-9845-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460991338-9845-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@kernel.org>, Josh Triplett <josh@joshtriplett.org>
List-Id: linux-ide@vger.kernel.org

Add __init attribute on a function that is only called from other __init
functions and that is not inlined, at least with gcc version 4.8.4 on an
x86 machine with allyesconfig.  Currently, the function is put in the
.text.unlikely segment.  Declaring it as __init will cause it to be put in
the .init.text and to disappear after initialization.

The result of objdump -x on the function before the change is as follows:

0000000000000000 l     F .text.unlikely 00000000000000e4 cmd640x_init_one

And after the change it is as follows:

00000000000000d2 l     F .init.text	00000000000000df cmd640x_init_one

Done with the help of Coccinelle.  The semantic patch checks for local
static non-init functions that are called from an __init function and are
not called from any other function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/ide/cmd640.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/cmd640.c b/drivers/ide/cmd640.c
index 70f0a27..004243b 100644
--- a/drivers/ide/cmd640.c
+++ b/drivers/ide/cmd640.c
@@ -695,7 +695,7 @@ static const struct ide_port_info cmd640_port_info __initconst = {
 	.pio_mask		= ATA_PIO5,
 };
 
-static int cmd640x_init_one(unsigned long base, unsigned long ctl)
+static int __init cmd640x_init_one(unsigned long base, unsigned long ctl)
 {
 	if (!request_region(base, 8, DRV_NAME)) {
 		printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX not free.\n",
