From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] IDE: unsexport 3 functions
Date: Sun, 6 Feb 2005 14:32:01 +0100
Message-ID: <20050206133201.GO3129@stusta.de>
References: <20050205024404.GK19408@stusta.de> <58cb370e05020605256b3ea00e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12045 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261240AbVBFNcE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Feb 2005 08:32:04 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e05020605256b3ea00e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Feb 06, 2005 at 02:25:32PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > @@ -161,8 +161,6 @@
> >         return ide_stopped;
> >  }
> > 
> > -EXPORT_SYMBOL(do_rw_taskfile);
> > -
> 
> Is this patch against -mm or ide-dev-2.6?

This is against -mm.
But the only changes regarding do_rw_taskfile in -mm come from 
bk-ide-dev.

> do_rw_taskfile() is still needed for ide-disk.c in linus' tree,
> the other two exports can be removed

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

