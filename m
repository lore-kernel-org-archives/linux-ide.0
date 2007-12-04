From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Tue, 04 Dec 2007 11:21:09 +0900
Message-ID: <4754B995.4010800@gmail.com>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn> <474F64F5.9070205@gmail.com> <006101c83301$bf79bef0$6539a8c0@usish.com.cn> <474FA9B6.105@gmail.com> <008f01c8331a$50efacb0$6539a8c0@usish.com.cn> <474FAECC.6070303@gmail.com> <009901c8331c$30d2c780$6539a8c0@usish.com.cn> <474FB1FB.9050904@gmail.com> <009b01c8331e$e8f40200$6539a8c0@usish.com.cn> <474FC845.7050308@gmail.com> <006301c83596$2e58fed0$6539a8c0@usish.com.cn> <4754A368.70806@gmail.com> <002d01c83615$79261090$6539a8c0@usish.com.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090101030703050809040400"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:59931 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbXLDCVP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 21:21:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2941021rvb
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 18:21:14 -0800 (PST)
In-Reply-To: <002d01c83615$79261090$6539a8c0@usish.com.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sam song <sam_song@usish.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090101030703050809040400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

sam song wrote:
=>> Hmmm... It's timeout.  How long does the command take?  It's a bit weird
>> because 36000s but the reported command duration is 136s.  How long did
>> the command take actually?
> 
> The command did actually take 136minutes25seconds. I set the timeout in app
> as 36000seconds(10-hour). 

Right, 136m.  I wonder whether it's hitting some hard timeout limit in
the kernel.  Hmmmm... Does the attached patch fix your problem?

Thanks.

-- 
tejun

--------------090101030703050809040400
Content-Type: text/x-patch;
 name="sg_io-fix-jiffies-conversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sg_io-fix-jiffies-conversion.patch"

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 91c7322..9675b34 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -230,7 +230,7 @@ static int blk_fill_sghdr_rq(struct request_queue *q, struct request *rq,
 	rq->cmd_len = hdr->cmd_len;
 	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
-	rq->timeout = (hdr->timeout * HZ) / 1000;
+	rq->timeout = msecs_to_jiffies(hdr->timeout);
 	if (!rq->timeout)
 		rq->timeout = q->sg_timeout;
 	if (!rq->timeout)
@@ -366,7 +366,7 @@ static int sg_io(struct file *file, struct request_queue *q,
 	 */
 	blk_execute_rq(q, bd_disk, rq, 0);
 
-	hdr->duration = ((jiffies - start_time) * 1000) / HZ;
+	hdr->duration = jiffies_to_msecs(jiffies - start_time);
 
 	return blk_complete_sghdr_rq(rq, hdr, bio);
 out:

--------------090101030703050809040400--
