From: David Miller <davem@davemloft.net>
Subject: Re: WARNINGs because of ide-proc handling
Date: Fri, 03 Sep 2010 07:35:03 -0700 (PDT)
Message-ID: <20100903.073503.191401190.davem@davemloft.net>
References: <20100902.151416.242137052.davem@davemloft.net>
	<20100903055328.GA11991@pengutronix.de>
	<20100903.053437.68134749.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42182
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755467Ab0ICOer (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2010 10:34:47 -0400
In-Reply-To: <20100903.053437.68134749.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

From: David Miller <davem@davemloft.net>
Date: Fri, 03 Sep 2010 05:34:37 -0700 (PDT)

> From: Wolfram Sang <w.sang@pengutronix.de>
> Date: Fri, 3 Sep 2010 07:53:28 +0200
> 
>> 
>>> Thanks for your analysis and suggested patch, I'll take a look at this.
>> 
>> Thanks for your help. If we can't find something, I'll just do a bisect this
>> weekend.
> 
> Frankly, at this point, I'm beginning suspect that the procfs stuff
> simply never warned at some point in the past and that the IDE
> code has had this problem for a while.

I just confirmed that the procfs code only started warning on removal
of non-present entries this past March, so basically the IDE code has
silently had this problem of not actually creating any of it's procfs
nodes for some time now.

Wolfram I'll look into your patch some more and integrate it, thanks.

commit 12bac0d9f4dbf3445a0319beee848d15fa32775e
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Fri Mar 5 13:44:00 2010 -0800

    proc: warn on non-existing proc entries
    
    * warn if creation goes on to non-existent directory
    * warn if removal goes on from non-existing directory
    * warn if non-existing proc entry is removed
    
    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
    Cc: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index ce2d954..08f4d71 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -312,8 +312,10 @@ static int __xlate_proc_name(const char *name, struct proc_dir_entry **ret,
 			if (proc_match(len, cp, de))
 				break;
 		}
-		if (!de)
+		if (!de) {
+			WARN(1, "name '%s'\n", name);
 			return -ENOENT;
+		}
 		cp += len + 1;
 	}
 	*residual = cp;
@@ -818,8 +820,10 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 		}
 	}
 	spin_unlock(&proc_subdir_lock);
-	if (!de)
+	if (!de) {
+		WARN(1, "name '%s'\n", name);
 		return;
+	}
 
 	spin_lock(&de->pde_unload_lock);
 	/*
