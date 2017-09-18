From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH][V2] libata: make const arrays static, reduces object code
 size
Date: Mon, 18 Sep 2017 19:54:35 +0300
Message-ID: <5dd9e5be-22c3-f2c3-9a55-ac44591600fe@cogentembedded.com>
References: <20170918133219.31293-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:49473 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932783AbdIRQyj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 18 Sep 2017 12:54:39 -0400
Received: by mail-lf0-f49.google.com with SMTP id r17so1194311lff.6
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2017 09:54:38 -0700 (PDT)
In-Reply-To: <20170918133219.31293-1-colin.king@canonical.com>
Content-Language: en-MW
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Tejun Heo <tj@kernel.org>, Mark Fasheh <mfasheh@versity.com>, Joel Becker <jlbec@evilplan.org>, Andrew Morton <akpm@linux-foundation.org>, piaojun <piaojun@huawei.com>, linux-ide@vger.kernel.org, ocfs2-devel@oss.oracle.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello!

On 09/18/2017 04:32 PM, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate const arrays on the stack, instead make them static.
> Makes the object code smaller by over 260 bytes:
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/ata/libata-scsi.c  | 10 +++++-----
>   fs/ocfs2/dlm/dlmrecovery.c |  1 -
>   2 files changed, 5 insertions(+), 6 deletions(-)
[...]
> diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
> index 74407c6dd592..31a61e8e0152 100644
> --- a/fs/ocfs2/dlm/dlmrecovery.c
> +++ b/fs/ocfs2/dlm/dlmrecovery.c
> @@ -1129,7 +1129,6 @@ static int dlm_send_mig_lockres_msg(struct dlm_ctxt *dlm,
>   		(mres->num_locks * sizeof(struct dlm_migratable_lock));
>   
>   	/* add an all-done flag if we reached the last lock */
> -	orig_flags = mres->flags;

    What's that? :-/

>   	BUG_ON(total_locks > mres_total_locks);
>   	if (total_locks == mres_total_locks)
>   		mres->flags |= DLM_MRES_ALL_DONE;

MBR, Sergei
