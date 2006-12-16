From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH -stable] SCSI: add missing cdb clearing in scsi_execute()
Date: Sat, 16 Dec 2006 20:02:32 +0900
Message-ID: <20061216110232.GF5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: jens.axboe@oracle.com, dougg@torque.net, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, stable@kernel.org
List-Id: linux-ide@vger.kernel.org

Clear-garbage-after-CDB patch missed scsi_execute() and it causes some
ODDs (HL-DT-ST DVD-RAM GSA-H30N) choke during SCSI scan.  Note that
this patch is only for -stable.  There is another more reliable fix
for this problem proposed for devel tree.

http://thread.gmane.org/gmane.linux.ide/14605/focus=14605

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1748e27..644f711 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -191,6 +191,7 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 		goto out;
 
 	req->cmd_len = COMMAND_SIZE(cmd[0]);
+	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sense;
 	req->sense_len = 0;
