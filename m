From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC: 2.6 patch] IDE: unsexport 3 functions
Date: Sun, 6 Feb 2005 14:25:32 +0100
Message-ID: <58cb370e05020605256b3ea00e@mail.gmail.com>
References: <20050205024404.GK19408@stusta.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.196]:39436 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261229AbVBFNZc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2005 08:25:32 -0500
Received: by wproxy.gmail.com with SMTP id 67so718782wri
        for <linux-ide@vger.kernel.org>; Sun, 06 Feb 2005 05:25:32 -0800 (PST)
In-Reply-To: <20050205024404.GK19408@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> @@ -161,8 +161,6 @@
>         return ide_stopped;
>  }
> 
> -EXPORT_SYMBOL(do_rw_taskfile);
> -

Is this patch against -mm or ide-dev-2.6?

do_rw_taskfile() is still needed for ide-disk.c in linus' tree,
the other two exports can be removed
