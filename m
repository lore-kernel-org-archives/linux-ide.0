From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] ata/kconfig: Re: Why SCSI module needed for PCI-IDE ATA
 only disks ?
Date: Tue, 5 Dec 2006 19:54:27 -0800
Message-ID: <20061205195427.b5c44f83.randy.dunlap@oracle.com>
References: <fa.juE97gahpb4n2kNNH/Todtcvh3s@ifi.uio.no>
	<fa.IqtlZas3d+ZPuhF6S6N/ivdF8Wo@ifi.uio.no>
	<fa.HDRhmOhDQliejH7ijqJBWw9Jw0o@ifi.uio.no>
	<45761B2F.9060804@shaw.ca>
	<457625CF.2080105@comcast.net>
	<45762781.8020207@shaw.ca>
	<45762F1E.4030805@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:40322 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759896AbWLFDxt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Dec 2006 22:53:49 -0500
In-Reply-To: <45762F1E.4030805@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ed Sweetman <safemode2@comcast.net>, jgarzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, 05 Dec 2006 21:46:54 -0500 Ed Sweetman wrote:

-ETOOMANYWORDS && -ENOPATCH, so here is one to consider.
Help text can also be added.  <supply text>
This is similar to what USB storage already does.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Provide more clues about SCSI config options that are needed
for libata (SATA/PATA) drivers.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/Kconfig |    9 +++++++++
 1 file changed, 9 insertions(+)

--- linux-2.6.19-git7.orig/drivers/ata/Kconfig
+++ linux-2.6.19-git7/drivers/ata/Kconfig
@@ -17,6 +17,15 @@ config ATA
 	  that "speaks" the ATA protocol, also called ATA controller),
 	  because you will be asked for it.
 
+comment "NOTE: ATA enables basic SCSI support; *however*,"
+	depends on ATA
+comment "+ 'SCSI disk support', 'SCSI tape support', or '"
+	depends on ATA
+comment "+ 'SCSI CDROM support' may also be needed,"
+	depends on ATA
+comment "+ depending on your hardware configuration."
+	depends on ATA
+
 if ATA
 
 config SATA_AHCI
