From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 2.6.9-rc2 12/16] scsi/sata_sx4: replace schedule_timeout() with msleep()/ssleep()
Date: Mon, 27 Sep 2004 11:29:37 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040927182937.GA1676@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.129]:19102 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267184AbUI0S3S
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Sep 2004 14:29:18 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: James.Bottomley@SteelEye.com, jgarzik@pobox.com
Cc: kernel-janitors@lists.osdl.org, linux-ide@vger.kernel.org

Any comments would be appreciated.

Description: Use msleep()/ssleep() [as appropriate]
instead of schedule_timeout() to guarantee the task delays as
expected.

--- 2.6.9-rc2-vanilla/drivers/scsi/sata_sx4.c	2004-09-13 17:15:56.000000000 -0700
+++ 2.6.9-rc2/drivers/scsi/sata_sx4.c	2004-09-27 11:28:10.000000000 -0700
@@ -1189,8 +1189,7 @@ static unsigned int pdc20621_prog_dimm_g
 	   		error = 0;
 	   		break;     
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((i * 100) * HZ / 1000 + 1);
+		msleep(i * 100);
    	}
    	return error;
 }
@@ -1223,8 +1222,7 @@ static unsigned int pdc20621_dimm_init(s
 	readl(mmio + PDC_TIME_CONTROL);
 
 	/* Wait 3 seconds */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(3 * HZ);
+	ssleep(3);
 
 	/* 
 	   When timer is enabled, counter is decreased every internal
