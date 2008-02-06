From: Mikko Rapeli <mikko.rapeli@teleca.com>
Subject: Bug#401035: ST310211A and HPA ( was Re: Bug#401035: linux-image-2.6-686 - another misbehaving Seagate )
Date: Wed, 6 Feb 2008 10:11:22 +0200
Message-ID: <20080206081121.GA6119@fitfioullt278>
References: <20080204013239.639903001D@harold.telenet-ops.be>
Reply-To: Mikko Rapeli <mikko.rapeli@teleca.com>, 401035@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.401035.B401035.120228561416326@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20080204013239.639903001D@harold.telenet-ops.be>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Bart Champagne <bart@as35701.net>, 401035@bugs.debian.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

(cc'ing linux-ide)

On Mon, Feb 04, 2008 at 02:32:59AM +0100, Bart Champagne wrote:
> Just found another type of Seagate drives that shows this behaviour : 
> ST310211A
> Can this one be blacklisted as well ?

Yes, do you have a patch? And a dmesg dump of the drive in use with and 
without a patch?

If you do, please send them to upstream linux-ide@vger.kernel.org and hope
that the fix gets applied to Debian kernels too. Also, please test the
sata/pata driver with your drive and add a blacklist there too.

If you don't have a patch, here's one for 2.6.24 to go.

>From 4a8b40c53d2e539bad3f93996f599d69a16af94b Mon Sep 17 00:00:00 2001
From: Mikko Rapeli <mikko.rapeli@teleca.com>
Date: Wed, 6 Feb 2008 09:41:14 +0200
Subject: [PATCH] ST310211A has buggy HPA too.

Signed-off-by: Mikko Rapeli <mikko.rapeli@teleca.com>
---
 drivers/ata/libata-core.c |    1 +
 drivers/ide/ide-disk.c    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6380726..d08f869 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4169,6 +4169,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices which report 1 sector over size HPA */
 	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
 	{ "ST320413A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
+	{ "ST310211A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
 
 	/* Devices which get the IVB wrong */
 	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB, },
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index b178190..a0f9940 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -462,6 +462,7 @@ static inline int idedisk_supports_lba48(const struct hd_driveid *id)
 static const struct drive_list_entry hpa_list[] = {
 	{ "ST340823A",	NULL },
 	{ "ST320413A",	NULL },
+	{ "ST310211A",	NULL },
 	{ NULL,		NULL }
 };
 
-- 
1.4.4.4
