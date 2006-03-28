From: Brian King <brking@us.ibm.com>
Subject: [PATCH 0/2] scsi: Add max_cmd_len to struct scsi_device
Date: Tue, 28 Mar 2006 16:17:12 -0600
Message-ID: <4429B5E8.6060204@us.ibm.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, James.Bottomley@steeleye.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

James/Jeff,

The following 2 patches add a max_cmd_len field to the scsi_device
struct. This is in response the the thread that resulted from
one of my SAS/SATA patches:

http://marc.theaimsgroup.com/?l=linux-scsi&m=114263742004656&w=2

Please apply.

Thanks,

Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
