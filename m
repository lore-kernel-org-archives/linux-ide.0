From: Brad Campbell <brad@wasp.net.au>
Subject: libata & scsi error handling
Date: Wed, 18 Aug 2004 01:22:34 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4122771A.4070203@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:24784 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268473AbUHQVWG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2004 17:22:06 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

G'day Jeff

I think I have this timeout error issue pegged now.

I know this is both wrong, ugly and likely to cause internal kernel damage, but for the purpose of 
pegging what I think may be the culprit it works around the error nicely here

brad@srv:/usr/src$ diff -u temp/linux-2.6.8.1/drivers/scsi/libata-scsi.c 
linux-2.6.8.1/drivers/scsi/libata-scsi.c
--- temp/linux-2.6.8.1/drivers/scsi/libata-scsi.c       2004-08-14 14:55:19.000000000 +0400
+++ linux-2.6.8.1/drivers/scsi/libata-scsi.c    2004-08-18 01:04:11.000000000 +0400
@@ -213,6 +213,7 @@

         ap = (struct ata_port *) &host->hostdata[0];
         ap->ops->eng_timeout(ap);
+       host->host_failed--;

         DPRINTK("EXIT\n");
         return 0;

The issue is that the libata installed eh_strategy_handler does not complete the error as
scsi_unjam_host -> scsi_eh_abort_cmds -> scsi_eh_finish_cmd does.

This leaves shost->host_failed to increment to one above shost->host_busy which means in 
scsi_eh_wakeup we never actually wakeup the error handler thread after the first error.

By adding that line above and doing a
dd if=/dev/sda count=1 > /dev/null

I get constant errors every 20 seconds (which is right given it's incrementing lba by 1 sector at a 
time and readahead seems to ask it to read 0x7F. I assume if I left it be it would error out after 
0x7F retries and then die.) If I plug the cable back in, boom dd drops a read error and we are back 
in business.

I'm not sure where to go from here as I can't seem to find a way to call scsi_eh_finish_cmd from 
within libata-scsi and I'm really well out of my depth here. I hope I can at least contribute to 
debugging.

Regards,
Brad
