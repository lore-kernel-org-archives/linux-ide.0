From: Richard Kennedy <richard@rsk.demon.co.uk>
Subject: [PATCH] libata: reorder ata_queued_cmd to remove alignment padding
 on 64 bit builds
Date: Fri, 10 Sep 2010 12:19:43 +0100
Message-ID: <1284117583.1903.8.camel@castor.rsk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Reorder structure ata_queued_cmd to remove 8 bytes of alignment padding
on 64 bit builds & therefore reduce the size of structure ata_port by
256 bytes.
    
Overall this will have little impact, other than reducing the amount of
memory that is cleared when allocating ata_ports.
    
Signed-off-by: Richard Kennedy <richard@rsk.demon.co.uk>
----
patch against 2.6.36-rc3
compiled & tested on x86_64

I've been running this patch for a couple of weeks with no apparent
issues.

regards
Richard



diff --git a/include/linux/libata.h b/include/linux/libata.h
index f010f18..e115380 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -559,13 +559,13 @@ struct ata_queued_cmd {
 	unsigned int		extrabytes;
 	unsigned int		curbytes;
 
-	struct scatterlist	*cursg;
-	unsigned int		cursg_ofs;
-
 	struct scatterlist	sgent;
 
 	struct scatterlist	*sg;
 
+	struct scatterlist	*cursg;
+	unsigned int		cursg_ofs;
+
 	unsigned int		err_mask;
 	struct ata_taskfile	result_tf;
 	ata_qc_cb_t		complete_fn;
