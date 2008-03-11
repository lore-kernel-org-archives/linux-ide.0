From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Tue, 11 Mar 2008 12:21:30 +0900
Message-ID: <47D5FABA.6040201@gmail.com>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn> <474F64F5.9070205@gmail.com> <006101c83301$bf79bef0$6539a8c0@usish.com.cn> <474FA9B6.105@gmail.com> <008f01c8331a$50efacb0$6539a8c0@usish.com.cn> <474FAECC.6070303@gmail.com> <009901c8331c$30d2c780$6539a8c0@usish.com.cn> <474FB1FB.9050904@gmail.com> <009b01c8331e$e8f40200$6539a8c0@usish.com.cn> <474FC845.7050308@gmail.com> <006301c83596$2e58fed0$6539a8c0@usish.com.cn> <4754A368.70806@gmail.com> <002d01c83615$79261090$6539a8c0@usish.com.cn> <4754B995.4010800@gmail.com> <47560245.70306@gmail.com> <000001c836e8$1ef1ba10$6539a8c0@usish.com.cn> <475617F8.7090607@gmail.com> <008601c88326$753395d0$5239a8c0@usish.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:5715 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYCKDVj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 23:21:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2272766wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 20:21:39 -0700 (PDT)
In-Reply-To: <008601c88326$753395d0$5239a8c0@usish.com.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sam song <sam_song@usish.com>
Cc: linux-ide@vger.kernel.org

sam song wrote:
> Dear Tejun,
> 
>> sam song wrote:
>>> Still one puzzle to consult with you. As you mentioned, the ATA Pass
> Thru in
>>> SELS10 2.6.16.21-0.8 is "broken". So what is the workable vanilla kernel
>>> besides 2.6.23.X? I
>>> need to have more choice on distribution. For example 2.6.18.X vanilla
>>> kernel with your patch can work?
>> Well. libata has been developing pretty fast.  I think post 2.6.20
>> should be fine but not too sure.  Does anyone remember better?
> 
> Until now, I have confirmed that the following kernel can support the
> special long time command after applied your patch in block/scsi_ioctl.c.
> 
> RHEL4.5 - 2.6.9-55
> RHEL5 - 2.6.18-8
> Vanilla kernel 2.6.23
> 
> I saw your patch in the main tree already. Actually, the key change workable
> for me is the following piece - timeout only.
> 
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 91c7322..9675b34 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -230,7 +230,7 @@ static int blk_fill_sghdr_rq(struct request_queue *q,
> struct request *rq,
>  	rq->cmd_len = hdr->cmd_len;
>  	rq->cmd_type = REQ_TYPE_BLOCK_PC;
>  
> -	rq->timeout = (hdr->timeout * HZ) / 1000;
> +	rq->timeout = msecs_to_jiffies(hdr->timeout);
>  	if (!rq->timeout)
>  		rq->timeout = q->sg_timeout;
>  	if (!rq->timeout)
> 
> FYI.

Great, thanks.

-- 
tejun
