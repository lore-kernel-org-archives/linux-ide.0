From: Jeremy Higdon <jeremy@sgi.com>
Subject: [PATCH 2.6.9-rc2] per-port LED control for sata_vsc
Date: Wed, 29 Sep 2004 21:25:52 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040930042552.GB201009@sgi.com>
References: <8746466a04092114163b3c0618@mail.gmail.com> <415B34FC.8060908@pobox.com> <8746466a0409291532471417b8@mail.gmail.com> <20040930023428.GA200873@sgi.com> <415B7D53.9020101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:59353 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268714AbUI3E2o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2004 00:28:44 -0400
Content-Disposition: inline
In-Reply-To: <415B7D53.9020101@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave <dave.jiang@gmail.com>, linux-ide@vger.kernel.org

On Wed, Sep 29, 2004 at 11:28:19PM -0400, Jeff Garzik wrote:
> 
> So maybe you or Dave could be convinced to roll that into a separate 
> patch, since we have consensus on that item?

I changed my mind.  Here's the patch.  I decided that I wanted a
big comment about this.

There may be a small offset to the latest version of this driver,
Jeff.  If it's a problem, let me know and I'll regenerate.


signed-off-by: Jeremy Higdon <jeremy@sgi.com>

===== drivers/scsi/sata_vsc.c 1.19 vs edited =====
--- 1.19/drivers/scsi/sata_vsc.c	2004-09-15 23:45:15 -07:00
+++ edited/drivers/scsi/sata_vsc.c	2004-09-29 21:12:40 -07:00
@@ -333,6 +333,14 @@
 
 	pci_set_master(pdev);
 
+	/* 
+	 * Config offset 0x98 is "Extended Control and Status Register 0"
+	 * Default value is (1 << 28).  All bits except bit 28 are reserved in
+	 * DPA mode.  If bit 28 is set, LED 0 reflects all ports' activity.
+	 * If bit 28 is clear, each port has its own LED.
+	 */
+	pci_write_config_dword(pdev, 0x98, 0);
+
 	/* FIXME: check ata_device_add return value */
 	ata_device_add(probe_ent);
 	kfree(probe_ent);
