From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH libata-dev-2.6 03/05] libata: update ATA PT sense desc code
Date: Thu, 17 Mar 2005 17:20:16 -0500 (EST)
Message-ID: <20050317221753.15A7ADF6@lns1032.lss.emc.com>
References: <20050317221753.53957EDF@lns1032.lss.emc.com>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <20050317221753.53957EDF@lns1032.lss.emc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

03_libata_update_desc_code.patch

	Change the ATA pass through sense block descriptor code to
	0x09 per SAT

Signed-off-by: Brett Russ <russb@emc.com>

 libata-scsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: libata-dev-2.6/drivers/scsi/libata-scsi.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/libata-scsi.c	2005-03-08 08:47:48.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-03-17 17:16:58.000000000 -0500
@@ -531,7 +531,7 @@ void ata_pass_thru_cc(struct ata_queued_
 	 */
 	sb[0] = 0x72 ;
 
-	desc[0] = 0x8e ;	/* TODO: replace with official value. */
+	desc[0] = 0x09;
 
 	/*
 	 * Set length of additional sense data.
@@ -2059,7 +2059,7 @@ void ata_scsi_simulate(u16 *id,
 			ata_scsi_rbuf_fill(&args, ata_scsiop_report_luns);
 			break;
 
-		/* mandantory commands we haven't implemented yet */
+		/* mandatory commands we haven't implemented yet */
 		case REQUEST_SENSE:
 
 		/* all other commands */
