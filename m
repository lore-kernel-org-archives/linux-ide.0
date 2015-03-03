From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] ide_tape: convert jiffies with jiffies_to_msecs
Date: Tue, 03 Mar 2015 17:11:13 +0300
Message-ID: <54F5C101.9070409@cogentembedded.com>
References: <1425379971-12641-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:43238 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbbCCOLT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Mar 2015 09:11:19 -0500
Received: by labgf13 with SMTP id gf13so13031707lab.10
        for <linux-ide@vger.kernel.org>; Tue, 03 Mar 2015 06:11:18 -0800 (PST)
In-Reply-To: <1425379971-12641-1-git-send-email-hofrat@osadl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>, "David S. Miller" <davem@davemloft.net>
Cc: Joe Perches <joe@perches.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 3/3/2015 1:52 PM, Nicholas Mc Guire wrote:

> Use jiffies_to_msecs for converting jiffies as it handles all of the corner
> cases reliably and also helps readability. The printk format is fixed up
> as jiffies_to_msecs returns unsigned int not unsigned long.

> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---

> v2: change printk format string from %d to %u as suggested by
>      Joe Perches <joe@perches.com>.

> Note that this patch will give a checkpatch warning due to "quoted string
> split across lines" but thats not related to this change.

> This was only compile tested with x86_64_defconfig + CONFIG_IDE=m,
> CONFIG_BLK_DEV_IDETAPE=m

> Patch is against 4.0-rc1 (localversion-next is -next-20150303)
>
>   drivers/ide/ide-tape.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

    The driver is called ide-tape.c, yet your subject prefix is "ide_tape:".

WBR, Sergei

