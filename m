From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] MAINTAINERS: libata pata: fix Jens Axboe's email address
Date: Mon, 27 Aug 2018 08:28:23 -0600
Message-ID: <f3d1c1b3-94af-3ea2-22ce-afaa1948ba1e@kernel.dk>
References: <d99162f25e4860bb04f1f56f031d11ceab1fc725.1535344175.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d99162f25e4860bb04f1f56f031d11ceab1fc725.1535344175.git.baruch@tkos.co.il>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 8/26/18 10:29 PM, Baruch Siach wrote:
> Commit 7634ccd2da (libata: maintainership update) added an invalid email
> address. Fix that.

Hah, what a mess. Outside of that, the git trees should also
be updated. Something like the below. I'll send in an update.

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..9ad052aeac39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8255,9 +8255,9 @@ F:	drivers/ata/pata_arasan_cf.c
 
 LIBATA PATA DRIVERS
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
-M:	Jens Axboe <kernel.dk>
+M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	drivers/ata/pata_*.c
 F:	drivers/ata/ata_generic.c
@@ -8275,7 +8275,7 @@ LIBATA SATA AHCI PLATFORM devices support
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	drivers/ata/ahci_platform.c
 F:	drivers/ata/libahci_platform.c
@@ -8291,7 +8291,7 @@ F:	drivers/ata/sata_promise.*
 LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	drivers/ata/
 F:	include/linux/ata.h

-- 
Jens Axboe
