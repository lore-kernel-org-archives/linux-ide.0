From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] clear garbage after CDBs on SG_IO
Date: Thu, 16 Nov 2006 20:47:37 +0900
Message-ID: <455C4FD9.2000608@gmail.com>
References: <20061116005227.GD27684@htj.dyndns.org> <20061116004903.ed9b81ac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:55864 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1031177AbWKPLru (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Nov 2006 06:47:50 -0500
Received: by nz-out-0102.google.com with SMTP id l1so259264nzf
        for <linux-ide@vger.kernel.org>; Thu, 16 Nov 2006 03:47:50 -0800 (PST)
In-Reply-To: <20061116004903.ed9b81ac.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, dougg@torque.net, mfluhr@nero.com, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com, linux-ide@vger.kernel.org

Andrew Morton wrote:
> On Thu, 16 Nov 2006 09:52:27 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> ATAPI devices transfer fixed number of bytes for CDBs (12 or 16).
>> Some ATAPI devices choke when shorter CDB is used and the left bytes
>> contain garbage.  Block SG_IO cleared left bytes but SCSI SG_IO
>> didn't.  This patch makes SCSI SG_IO clear it and simplify CDB
>> clearing in block SG_IO.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: Mathieu Fluhr <mfluhr@nero.com>
>>
>> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
>> index 2dc3264..cac7f18 100644
>> --- a/block/scsi_ioctl.c
>> +++ b/block/scsi_ioctl.c
>> @@ -286,9 +286,8 @@ static int sg_io(struct file *file, requ
>>  	 * fill in request structure
>>  	 */
>>  	rq->cmd_len = hdr->cmd_len;
>> +	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
> 
> s/req/rq/ makes the compiler happier there.

Yeap, apparently.  Sorry.  Last minute copy and paste w/ comment. 
Arggh... No change is ever safe.

-- 
tejun
