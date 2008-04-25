From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting
 out WARN_ON()
Date: Fri, 25 Apr 2008 09:44:58 +0900
Message-ID: <4811298A.4070903@gmail.com>
References: <480F231A.7020401@gmail.com> <200804240615.23463.volker.armin.hemmann@tu-clausthal.de> <48100A8B.4000102@gmail.com> <200804250217.34418.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:6618 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbYDYApI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 20:45:08 -0400
Received: by wa-out-1112.google.com with SMTP id m16so5682290waf.23
        for <linux-ide@vger.kernel.org>; Thu, 24 Apr 2008 17:45:06 -0700 (PDT)
In-Reply-To: <200804250217.34418.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

Volker Armin Hemmann wrote:
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git 
> upstream:upstream
> From git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev
>  * [new branch]      upstream   -> upstream
> energy libata-dev # git checkout -f upstream
> Checking out files: 100% (1243/1243), done.
> Switched to branch "upstream"
> energy libata-dev # patch -p1 < ../ahci.patch
> patching file drivers/ata/ahci.c
> Hunk #1 FAILED at 556.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c.rej

That's really weird.

$ git fetch -f -u git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git  upstream:upstream
remote: Counting objects: 7151, done.
remote: Compressing objects: 100% (1439/1439), done.
Indexing 5254 objects...
remote: Total 5254 (delta 4424), reused 4645 (delta 3815)
 100% (5254/5254) done
Resolving 4424 deltas...
 100% (4424/4424) done
1186 objects were added to complete this thin pack.
* refs/heads/upstream: forcing update to non-fast forward branch 'upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev
  old...new: ed75ba5...48feb3c
$ git checkout -f upstream
Checking 1203 files out...
 100% (1203/1203) done
Switched to branch "upstream"
$ filterdiff ~/tmp/\[PATCH\]\ ahci\:\ retry\ enabling\ AHCI\ a\ few\ times\ before\ spitting\ out\ WARN_ON\(\).eml | patch -p1
patching file drivers/ata/ahci.c
$ git diff
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 739ba3f..711b5d7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -556,16 +556,27 @@ static inline void __iomem *ahci_port_base(struct ata_port *ap)
 
 static void ahci_enable_ahci(void __iomem *mmio)
 {
+       int i;
        u32 tmp;
 
        /* turn on AHCI_EN */
        tmp = readl(mmio + HOST_CTL);
-       if (!(tmp & HOST_AHCI_EN)) {
+       if (tmp & HOST_AHCI_EN)
+               return;
+
+       /* Some controllers need AHCI_EN to be written multiple times.
+        * Try a few times before giving up.
+        */
+       for (i = 0; i < 5; i++) {
                tmp |= HOST_AHCI_EN;
                writel(tmp, mmio + HOST_CTL);
                tmp = readl(mmio + HOST_CTL);   /* flush && sanity check */
-               WARN_ON(!(tmp & HOST_AHCI_EN));
+               if (tmp & HOST_AHCI_EN)
+                       return;
+               msleep(10);
        }
+
+       WARN_ON(1);
 }
 
 /**


-- 
tejun
