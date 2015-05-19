From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: READ LOG DMA EXT failed, trying unqueued
Date: Tue, 19 May 2015 07:49:11 -0400
Message-ID: <yq1wq04kcso.fsf@sermon.lab.mkp.net>
References: <20150519113320.GA498@swordfish>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:37507 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbESLtS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2015 07:49:18 -0400
In-Reply-To: <20150519113320.GA498@swordfish> (Sergey Senozhatsky's message of
	"Tue, 19 May 2015 20:33:20 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>>>>> "Sergey" == Sergey Senozhatsky <sergey.senozhatsky@gmail.com> writes:

Sergey> Hello, my laptop doesn't boot anymore, spinning in "READ LOG DMA
Sergey> EXT failed, trying unqueued".  any reason it loops forever?

Does the patch below help?

Also, please let us know which drive you have and send us the output of:

# smartctl -l gplog,0x13 /dev/sdN

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering


diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2893563d0537..2b370ee0ae86 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1521,6 +1521,7 @@ retry:
 	} else {
 		tf.command = ATA_CMD_READ_LOG_EXT;
 		tf.protocol = ATA_PROT_PIO;
+		dma = false;
 	}
 	tf.lbal = log;
 	tf.lbam = page;


