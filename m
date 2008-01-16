From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk
Date: Wed, 16 Jan 2008 11:58:37 +0900
Message-ID: <478D72DD.6030107@gmail.com>
References: <1200445210549-git-send-email-htejun@gmail.com> <20080115184808.e64aed5e.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:38117 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030AbYAPC6o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 21:58:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so148958wah.23
        for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2008 18:58:43 -0800 (PST)
In-Reply-To: <20080115184808.e64aed5e.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, daniel.ritz-ml@swissonline.ch, jeff@garzik.org, linux-ide@vger.kernel.org

Hello,

Randy Dunlap wrote:
>>   mprintk_set_header(&mp, KERN_INFO "ata%u.%2u: ", 1, 0);
>>   mprintk_push(&mp, "ATA %d", 7);
>>   mprintk_push(&mp, ", %u sectors\n", 1024);
>>   mprintk(&mp, "everything seems dandy\n");
> 
> Looks pretty good to me except that I would change mprintk_push to
> mprintk_add or mprintk_append (I think that I prefer _add).

I think push and flush sound good when used together but then again the
flush function isn't visible in the interface and push has LIFO ring to
it.  I'm okay with add.  append seems a bit too long.

Thanks.

-- 
tejun
