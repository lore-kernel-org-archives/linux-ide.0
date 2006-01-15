From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Date: Sun, 15 Jan 2006 02:50:27 +0100
Message-ID: <20060115015027.GY29663@stusta.de>
References: <20060114152119.GN29663@stusta.de> <1137255183.20915.0.camel@localhost.localdomain> <58cb370e0601140947medcb66flf6b7281976683765@mail.gmail.com> <20060114195521.GS29663@stusta.de> <1137287249.26046.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2827 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751567AbWAOBu1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jan 2006 20:50:27 -0500
Content-Disposition: inline
In-Reply-To: <1137287249.26046.13.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Andrey J. Melnikoff" <temnota@kmv.ru>

On Sun, Jan 15, 2006 at 01:07:29AM +0000, Alan Cox wrote:
> On Sad, 2006-01-14 at 20:55 +0100, Adrian Bunk wrote:
> > This patch removes the CONFIG_PDC202XX_FORCE=n case.
> 
> NAK. The Y case is the one you want to keep

Removing the N case is the same as keeping the Y case...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

