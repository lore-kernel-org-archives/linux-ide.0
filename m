From: Mikko Rapeli <mikko.rapeli@teleca.com>
Subject: Bug#401035: ST310211A and HPA ( was Re: Bug#401035: linux-image-2.6-686 - another misbehaving Seagate )
Date: Fri, 8 Feb 2008 12:41:52 +0200
Message-ID: <20080208104152.GF6119@fitfioullt278>
References: <20080204013239.639903001D@harold.telenet-ops.be> <20080206081121.GA6119@fitfioullt278> <20080207211309.92F0F30034@harold.telenet-ops.be>
Reply-To: Mikko Rapeli <mikko.rapeli@teleca.com>, 401035@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.401035.B401035.120246732314889@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20080207211309.92F0F30034@harold.telenet-ops.be>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Bart Champagne <bart@as35701.net>
Cc: 401035@bugs.debian.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Feb 07, 2008 at 10:13:42PM +0100, Bart Champagne wrote:
> Backporting the fix for 2.6.23 to the Debian 2.6.18 kernel hasn't 
> succeeded yet, my C has gone very rusty it seems.
> In attachment a dmesg log for this drive. When/if I get a working 
> patch I'll let you know.

I think this should work for 2.6.18 (2.6.18.dfsg.1-17etch1) in Debian 
(I backported the patches once before). I don't have my buggy hardware 
to test with me now, but this should work. Fetch the latest
linux-source-2.6.18 package, extract the tar ball from
/usr/src/linux-source*, apply the patch and test :)

Backported HPA fix git commits b0244a00451c1ad64bf0a51f50679f7146786780 
and 7062cdc5edb3ba4b2eb906684cd19e103de1f920 to Debian's 2.6.18. 
Added ST310211A as reported by Bart Champagne.

diff -ru linux-source-2.6.18/drivers/ide/ide-disk.c linux-source-2.6.18-idehpa/drivers/ide/ide-disk.c
--- linux-source-2.6.18/drivers/ide/ide-disk.c	2006-09-20 06:42:06.000000000 +0300
+++ linux-source-2.6.18-idehpa/drivers/ide/ide-disk.c	2008-02-08 12:11:30.000000000 +0200
@@ -482,6 +482,17 @@
 	       && id->lba_capacity_2;
 }
 
+/*
+ * Some disks report total number of sectors instead of
+ * maximum sector address.  We list them here.
+ */
+static const struct drive_list_entry hpa_list[] = {
+	{ "ST340823A",	"ALL" },
+	{ "ST320413A",	"ALL" },
+	{ "ST310211A",	"ALL" },
+	{ NULL,		NULL }
+};
+
 static void idedisk_check_hpa(ide_drive_t *drive)
 {
 	unsigned long long capacity, set_max;
@@ -493,6 +504,15 @@
 	else
 		set_max = idedisk_read_native_max_address(drive);
 
+	if (ide_in_drive_list(drive->id, hpa_list)) {
+		/*
+		 * Since we are inclusive wrt to firmware revisions do this
+		 * extra check and apply the workaround only when needed.
+		 */
+		if (set_max == capacity + 1)
+			set_max--;
+	}
+
 	if (set_max <= capacity)
 		return;
 
diff -ru linux-source-2.6.18/drivers/ide/ide-iops.c linux-source-2.6.18-idehpa/drivers/ide/ide-iops.c
--- linux-source-2.6.18/drivers/ide/ide-iops.c	2006-09-20 06:42:06.000000000 +0300
+++ linux-source-2.6.18-idehpa/drivers/ide/ide-iops.c	2008-02-08 10:54:15.000000000 +0200
@@ -589,6 +589,8 @@
 
 EXPORT_SYMBOL(ide_wait_stat);
 
+EXPORT_SYMBOL_GPL(ide_in_drive_list);
+
 /*
  *  All hosts that use the 80c ribbon must use!
  *  The name is derived from upper byte of word 93 and the 80c ribbon.
