From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 40/86] ide/generic: use uapi/linux/pci_ids.h directly
Date: Sun, 29 Mar 2015 17:12:45 +0300
Message-ID: <5518085D.4050805@cogentembedded.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com> <1427635734-24786-41-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35558 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbbC2OMt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Mar 2015 10:12:49 -0400
Received: by lbdc10 with SMTP id c10so37148881lbd.2
        for <linux-ide@vger.kernel.org>; Sun, 29 Mar 2015 07:12:47 -0700 (PDT)
In-Reply-To: <1427635734-24786-41-git-send-email-mst@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

Hello.

On 3/29/2015 4:40 PM, Michael S. Tsirkin wrote:

> Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
> use the new header directly so we can drop
> the wrapper in include/linux/pci_ids.h.

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/ide/ide-generic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> index 54d7c46..4edb39f 100644
> --- a/drivers/ide/ide-generic.c
> +++ b/drivers/ide/ide-generic.c
> @@ -11,7 +11,7 @@
>   #include <linux/init.h>
>   #include <linux/module.h>
>   #include <linux/ide.h>
> -#include <linux/pci_ids.h>
> +#include <uapi/linux/pci_ids.h>

    Hm, I thought include/uapi/ was always in #include file search path, so 
there should be no need to explicitly mention it, and so no need for this patch...

WBR, Sergei

