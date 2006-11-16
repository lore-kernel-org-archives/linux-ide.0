From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] clear garbage after CDBs on SG_IO
Date: Thu, 16 Nov 2006 00:49:03 -0800
Message-ID: <20061116004903.ed9b81ac.akpm@osdl.org>
References: <20061116005227.GD27684@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:60047 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422691AbWKPIuB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Nov 2006 03:50:01 -0500
In-Reply-To: <20061116005227.GD27684@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, dougg@torque.net, mfluhr@nero.com, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Thu, 16 Nov 2006 09:52:27 +0900
Tejun Heo <htejun@gmail.com> wrote:

> ATAPI devices transfer fixed number of bytes for CDBs (12 or 16).
> Some ATAPI devices choke when shorter CDB is used and the left bytes
> contain garbage.  Block SG_IO cleared left bytes but SCSI SG_IO
> didn't.  This patch makes SCSI SG_IO clear it and simplify CDB
> clearing in block SG_IO.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mathieu Fluhr <mfluhr@nero.com>
> 
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 2dc3264..cac7f18 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -286,9 +286,8 @@ static int sg_io(struct file *file, requ
>  	 * fill in request structure
>  	 */
>  	rq->cmd_len = hdr->cmd_len;
> +	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */

s/req/rq/ makes the compiler happier there.
