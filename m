From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] cleanup drivers/ata/Kconfig
Date: Tue, 15 Aug 2006 00:12:12 +0200
Message-ID: <20060814221212.GV3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813210106.GO3543@stusta.de> <1155509179.24077.172.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7175 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965009AbWHNWMN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Aug 2006 18:12:13 -0400
Content-Disposition: inline
In-Reply-To: <1155509179.24077.172.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Aug 13, 2006 at 11:46:19PM +0100, Alan Cox wrote:
> Ar Sul, 2006-08-13 am 23:01 +0200, ysgrifennodd Adrian Bunk:
> > One issue I noticed while creating this patch is that for the following 
> > options the dependency and the prompt don't agree whether the option
> > is EXPERIMENTAL:
> > - SATA_SX4
> > - PATA_AMD
> > - PATA_HPT3X3
> > - PATA_SC1200
> 
> HPT3x3, SC1200 are experimental
> AMD is not intended to be any more.
> 
> Thanks for spotting these.
>...

What's with SATA_SX4?
 
cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

