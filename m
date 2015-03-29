From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 40/86] ide/generic: use uapi/linux/pci_ids.h directly
Date: Sun, 29 Mar 2015 16:52:26 +0200
Message-ID: <20150329164934-mutt-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
 <1427635734-24786-41-git-send-email-mst@redhat.com>
 <5518085D.4050805@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59345 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbbC2Owc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Mar 2015 10:52:32 -0400
Content-Disposition: inline
In-Reply-To: <5518085D.4050805@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Sun, Mar 29, 2015 at 05:12:45PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 3/29/2015 4:40 PM, Michael S. Tsirkin wrote:
> 
> >Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
> >use the new header directly so we can drop
> >the wrapper in include/linux/pci_ids.h.
> 
> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >---
> >  drivers/ide/ide-generic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> >diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> >index 54d7c46..4edb39f 100644
> >--- a/drivers/ide/ide-generic.c
> >+++ b/drivers/ide/ide-generic.c
> >@@ -11,7 +11,7 @@
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/ide.h>
> >-#include <linux/pci_ids.h>
> >+#include <uapi/linux/pci_ids.h>
> 
>    Hm, I thought include/uapi/ was always in #include file search path, so
> there should be no need to explicitly mention it, and so no need for this
> patch...
> 
> WBR, Sergei

There's some confusion about whether headers should be preferably
included using #include <uapi/linux/...> or #include <linux/...>.
It might be a good idea to document this somewhere.

-- 
MST
