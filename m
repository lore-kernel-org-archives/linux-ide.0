From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_nv: ck804 has borked hardreset too
Date: Sun, 01 Feb 2009 10:56:31 +0900
Message-ID: <4985014F.7070607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40818 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbZBAB4r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2009 20:56:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

While playing with nvraid, I found out that rmmoding and insmoding
often trigger hardreset failure on the first port (the second one was
always okay).  Seriously, how diverse can you get with hardreset
behaviors?  Anyways, make ck804 use noclassify variant too.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Robert, ISTR that a user was reporting probing problem on ck804, I
think the user could have been seeing this.  The behavior on my
motherboard is very curious.  The problem is always with the first
port.  If booted from cdrom, it always fails.  If booted from
harddrive, the initial probing works fine but from the second time on,
it fails.  Argh...

 drivers/ata/sata_nv.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index c49ad0e..444af04 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -436,11 +436,16 @@ static struct ata_port_operations nv_nf2_ops = {
 	.hardreset		= nv_noclassify_hardreset,
 };
 
-/* CK804 finally gets hardreset right */
+/* For initial probing after boot and hot plugging, hardreset mostly
+ * works fine on CK804 but curiously, reprobing on the initial port by
+ * rescanning or rmmod/insmod fails to acquire the initial D2H Reg FIS
+ * in somewhat undeterministic way.  Use noclassify hardreset.
+ */
 static struct ata_port_operations nv_ck804_ops = {
 	.inherits		= &nv_common_ops,
 	.freeze			= nv_ck804_freeze,
 	.thaw			= nv_ck804_thaw,
+	.hardreset		= nv_noclassify_hardreset,
 	.host_stop		= nv_ck804_host_stop,
 };
 
