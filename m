From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH libata-dev-2.6 04/05] libata: support descriptor sense in ctrl page
Date: Thu, 17 Mar 2005 17:20:21 -0500 (EST)
Message-ID: <20050317221753.D65B81E4@lns1032.lss.emc.com>
References: <20050317221753.53957EDF@lns1032.lss.emc.com>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <20050317221753.53957EDF@lns1032.lss.emc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

04_libata_control_pg_desc_bit.patch

	libata must support the descriptor format sense blocks as they
	are required to properly report results of ATA pass through
	commands as well as other SCSI commands reporting 48b LBAs.
	This patch adjusts the control mode page to properly report
	this.

Signed-off-by: Brett Russ <russb@emc.com>

 libata-scsi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: libata-dev-2.6/drivers/scsi/libata-scsi.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/libata-scsi.c	2005-03-17 17:16:58.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-03-17 17:16:58.000000000 -0500
@@ -1370,7 +1370,12 @@ static unsigned int ata_msense_caching(u
 
 static unsigned int ata_msense_ctl_mode(u8 **ptr_io, const u8 *last)
 {
-	const u8 page[] = {0xa, 0xa, 2, 0, 0, 0, 0, 0, 0xff, 0xff, 0, 30};
+	const u8 page[] = {0xa, 0xa, 6, 0, 0, 0, 0, 0, 0xff, 0xff, 0, 30};
+
+	/* byte 2: set the descriptor format sense data bit (bit 2)
+	 * since we need to support returning this format for SAT
+	 * commands and any SCSI commands against a 48b LBA device.
+	 */
 
 	ata_msense_push(ptr_io, last, page, sizeof(page));
 	return sizeof(page);
