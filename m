From: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting out WARN_ON()
Date: Fri, 25 Apr 2008 03:17:16 +0200
Message-ID: <200804250317.16396.volker.armin.hemmann@tu-clausthal.de>
References: <480F231A.7020401@gmail.com> <200804250217.34418.volker.armin.hemmann@tu-clausthal.de> <4811298A.4070903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:57938 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752744AbYDYBRU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Apr 2008 21:17:20 -0400
In-Reply-To: <4811298A.4070903@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

On Freitag, 25. April 2008, Tejun Heo wrote:
> Volker Armin Hemmann wrote:
> > git fetch
> > git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.gi=
t
> > upstream:upstream
> > From git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-d=
ev
> >  * [new branch]      upstream   -> upstream
> > energy libata-dev # git checkout -f upstream
> > Checking out files: 100% (1243/1243), done.
> > Switched to branch "upstream"
> > energy libata-dev # patch -p1 < ../ahci.patch
> > patching file drivers/ata/ahci.c
> > Hunk #1 FAILED at 556.
> > 1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c=
=2Erej
>
> That's really weird.
>
> $ git fetch -f -u
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git=20
> upstream:upstream remote: Counting objects: 7151, done.
> remote: Compressing objects: 100% (1439/1439), done.
> Indexing 5254 objects...
> remote: Total 5254 (delta 4424), reused 4645 (delta 3815)
>  100% (5254/5254) done
> Resolving 4424 deltas...
>  100% (4424/4424) done
> 1186 objects were added to complete this thin pack.
> * refs/heads/upstream: forcing update to non-fast forward branch 'ups=
tream'
> of git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev
> old...new: ed75ba5...48feb3c
> $ git checkout -f upstream
> Checking 1203 files out...
>  100% (1203/1203) done
> Switched to branch "upstream"


git clone git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-=
dev.git
Initialized empty Git repository in /usr/src/libata-dev/.git/
remote: Counting objects: 743097, done.
remote: Compressing objects: 100% (127420/127420), done.
remote: Total 743097 (delta 617111), reused 740658 (delta 614672)
Receiving objects: 100% (743097/743097), 173.30 MiB | 7980 KiB/s, done.
Resolving deltas: 100% (617111/617111), done.
Checking out files: 100% (23824/23824), done.

energy src # cd libata-dev

energy libata-dev # git fetch -f -u=20
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git =20
upstream:upstream
=46rom git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev
 * [new branch]      upstream   -> upstream

git checkout -f upstream
Switched to branch "upstream"

cat ../ahci.patch
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 739ba3f..711b5d7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -556,16 +556,27 @@ static inline void __iomem *ahci_port_base(struct=
=20
ata_port *ap)

 static void ahci_enable_ahci(void __iomem *mmio)
 {
+       int i;
        u32 tmp;

        /* turn on AHCI_EN */
        tmp =3D readl(mmio + HOST_CTL);
-       if (!(tmp & HOST_AHCI_EN)) {
+       if (tmp & HOST_AHCI_EN)
+               return;
+
+       /* Some controllers need AHCI_EN to be written multiple times.
+        * Try a few times before giving up.
+        */
+       for (i =3D 0; i < 5; i++) {
                tmp |=3D HOST_AHCI_EN;
                writel(tmp, mmio + HOST_CTL);
                tmp =3D readl(mmio + HOST_CTL);   /* flush && sanity ch=
eck */
-               WARN_ON(!(tmp & HOST_AHCI_EN));
+               if (tmp & HOST_AHCI_EN)
+                       return;
+               msleep(10);
        }
+
+       WARN_ON(1);
 }

 /**
energy libata-dev # patch -p1 < ../ahci.patch
patching file drivers/ata/ahci.c
Hunk #1 FAILED at 556.
1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c.rej

somewhere I am doing something wrong. But what?

btw:
git --version
git version 1.5.4.5

Gl=FCck Auf,
Volkert
