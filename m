From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: drivers/ide/au1xxx-ide.c: use resource_size()
Date: Mon, 23 Nov 2009 13:15:32 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE5BFD@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753860AbZKWSP2@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Use resource_size() for {request/release}_mem_region and ioremap.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/drivers/ide/au1xxx-ide.c b/drivers/ide/au1xxx-ide.c
index 58121bd..87cef0c 100644
--- a/drivers/ide/au1xxx-ide.c
+++ b/drivers/ide/au1xxx-ide.c
@@ -532,14 +532,13 @@ static int au_ide_probe(struct platform_device *dev)
 		goto out;
 	}
 
-	if (!request_mem_region(res->start, res->end - res->start + 1,
-				dev->name)) {
+	if (!request_mem_region(res->start, resource_size(res), dev->name)) {
 		pr_debug("%s: request_mem_region failed\n", DRV_NAME);
 		ret =  -EBUSY;
 		goto out;
 	}
 
-	ahwif->regbase = (u32)ioremap(res->start, res->end - res->start + 1);
+	ahwif->regbase = (u32)ioremap(res->start, resource_size(res));
 	if (ahwif->regbase == 0) {
 		ret = -ENOMEM;
 		goto out;
@@ -575,7 +574,7 @@ static int au_ide_remove(struct platform_device *dev)
 	iounmap((void *)ahwif->regbase);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	return 0;
 } 
