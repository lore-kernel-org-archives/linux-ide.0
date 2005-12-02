From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 5/6] SATA ACPI: kernel-doc
Date: Fri, 2 Dec 2005 10:07:54 -0800
Message-ID: <20051202100754.6194bfb2.randy_d_dunlap@linux.intel.com>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:63651 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750886AbVLBSOC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Dec 2005 13:14:02 -0500
In-Reply-To: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: axboe@suse.de, jgarzik@pobox.com

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add ata_acpi.c to libata kernel-doc template file.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 Documentation/DocBook/libata.tmpl |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2615-rc4.orig/Documentation/DocBook/libata.tmpl
+++ linux-2615-rc4/Documentation/DocBook/libata.tmpl
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
