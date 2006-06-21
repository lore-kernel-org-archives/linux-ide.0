From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] drivers/ide/legacy/ide-cs.c: make 2 functions static
Date: Wed, 21 Jun 2006 23:57:29 +0200
Message-ID: <20060621215729.GL9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030321AbWFUV5d@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Thomas Kleffel <tk@maintech.de>, Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
>  git-pcmcia.patch
>...
>  git trees
>...

This patch makes two needlessly global functions static.
 
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ide/legacy/ide-cs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm1-full/drivers/ide/legacy/ide-cs.c.old	2006-06-21 22:54:20.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/ide/legacy/ide-cs.c	2006-06-21 22:54:37.000000000 +0200
@@ -170,11 +170,11 @@
         return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
 }
 
-void outb_io(unsigned char value, unsigned long port) {
+static void outb_io(unsigned char value, unsigned long port) {
 	outb(value, port);
 }
 
-void outb_mem(unsigned char value, unsigned long port) {
+static void outb_mem(unsigned char value, unsigned long port) {
 	writeb(value, (void __iomem *) port);
 }
 
