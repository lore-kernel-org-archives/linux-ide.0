From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/ide/: cleanups
Date: Tue, 11 Jul 2006 18:07:41 +0200
Message-ID: <20060711160741.GZ13938@stusta.de>
References: <20060711141637.GS13938@stusta.de> <1152634744.18028.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23044 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751131AbWGKQHm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 12:07:42 -0400
Content-Disposition: inline
In-Reply-To: <1152634744.18028.26.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 05:19:04PM +0100, Alan Cox wrote:
> Ar Maw, 2006-07-11 am 16:16 +0200, ysgrifennodd Adrian Bunk:
> > This patch contains the following cleanups:
> 
> > - ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)
> 
> NAK. A simple grep shows ide_register_hw has users, 5 in fact as of
> 2.6.17.

I know, and I checked them, and Sergei already pointed out that I missed 
the one that can be modular.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

