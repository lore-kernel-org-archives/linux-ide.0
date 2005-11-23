From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [RFC 4/5] ata_acpi: kernel-doc
Date: Wed, 23 Nov 2005 15:53:19 -0800
Message-ID: <20051123155319.5db6dfac.randy_d_dunlap@linux.intel.com>
References: <20051123154055.6ab5cab2.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:59064 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751340AbVKWXyp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Nov 2005 18:54:45 -0500
In-Reply-To: <20051123154055.6ab5cab2.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik <jgarzik@pobox.com>
Cc: ide <linux-ide@vger.kernel.org>

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add ata_acpi.c to libata kernel-doc template file.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
 Documentation/DocBook/libata.tmpl |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2615-rc2c.orig/Documentation/DocBook/libata.tmpl
+++ linux-2615-rc2c/Documentation/DocBook/libata.tmpl
@@ -787,6 +787,12 @@ and other resources, etc.
 !Idrivers/scsi/libata-scsi.c
   </chapter>
 
+  <chapter id="libataAcpi">
+     <title>libata ACPI interfaces/methods</title>
+!Edrivers/scsi/ata_acpi.c
+!Idrivers/scsi/ata_acpi.c
+  </chapter>
+
   <chapter id="ataExceptions">
      <title>ATA errors &amp; exceptions</title>
 


---
