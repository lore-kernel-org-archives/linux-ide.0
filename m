From: Dominic Curran <dominic.curran@citrix.com>
Subject: Possible bug in ide_cd_queue_pc() or ide_wait_stat() ?
Date: Wed, 28 Jul 2010 11:46:26 +0100
Message-ID: <4C500A82.2040805@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:9754 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397Ab0G1KuT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jul 2010 06:50:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I have some TEAC DV-28E-V CDROM drives that after polling for status 
starts to timeout requests (the time it takes to do this varies between 
5mins and 24hrs).

I believe only an APATPI reset gets them out of this timeout behaviour.


I assume this is down to bad firmware/hardware (the latest firmware has 
been applied).

I happens on multiply drives of this version.


BUT...

The problem is that even when the requests timeout the ioctl 
CDROM_DRIVE_STATUS will receive a status of CDS_DISC_OK.

This is obviously not the correct status (particularly when there is no 
CD disc in the drive).

 

I have added some instrumentation to the code and this is the general 
stack flow I see:

 

In the interrupt handler:
do_ide_request()
  ide_do_request()
    start_request()                   returns ide_stopped
      ide_wait_stat()                 returns -EBUSY
        ide_error()                   returns ide_stopped  +  stat=0xD0 {Busy}
          ide_dump_status()           returns 0 (so err=0)
	  rq->errors = 1;
	  ide_end_drive_cmd(err)      b/c err is 0, then sets rq->errors=0


In the ioctl:
ide_cdrom_drive_status() Returns CDS_DISC_OK
cdrom_check_status()     Returns 0.
  ide_cd_queue_pc()      Ignores the return from blk_execute_rq(). Checks for the flag REQ_FAILED in rq->cmd_flags (which is not set). Returns 0.
    blk_execute_rq()     Since rq->errors==1 and then returns 0
      wait_for_completion()

The problem seems to be that in ide_cd_queue_pc():
1) the error return from blk_execute_rq() is ignored
2) the REQ_FAILED in rq->cmd_flags is not set in the interrupt handler (which is what ide_cd_queue_pc() seems to be concerned about)

Anyone have any comments:
1) why in ide_dump_status() a stat of BUSY_STAT does not translate to an error return ?

2) Is setting rq->cmd_flags |= REQ_FAILED in ide_wait_stat() an acceptable way to solve issue. 
   Patch something like this...


Index: linux/drivers/ide/ide-iops.c                                                                     
===================================================================                                               
--- linux.orig/drivers/ide/ide-iops.c 2010-07-20 15:37:01.871300665 +0100                               
+++ linux/drivers/ide/ide-iops.c      2010-07-28 11:43:21.386752993 +0100                               
@@ -652,6 +657,9 @@ int ide_wait_stat(ide_startstop_t *start
        if (err) {
                char *s = (err == -EBUSY) ? "status timeout" : "status error";
                *startstop = ide_error(drive, s, stat);
+
+               if (err == -EBUSY)
+                       rq->cmd_flags |= REQ_FAILED;
        }

        return err;


I appreciate any pointers you can give
Thanks
dom
 

