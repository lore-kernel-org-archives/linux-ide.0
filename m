From: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH] remove dead PC9800 IDE support
Date: Sat, 15 May 2004 22:23:47 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040515202347.GA22742@fs.tum.de>
References: <200405040135.14688.bzolnier@elka.pw.edu.pl> <20040503163220.437c2921.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40394 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264724AbUEOUX4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 16:23:56 -0400
Content-Disposition: inline
In-Reply-To: <20040503163220.437c2921.rddunlap@osdl.org>
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rddunlap@osdl.org>, tomita@users.sourceforge.jp, a13a@users.sourceforge.jp
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 04:32:20PM -0700, Randy.Dunlap wrote:
> On Tue, 4 May 2004 01:35:14 +0200 Bartlomiej Zolnierkiewicz wrote:
> 
> | 
> | It was added in 2.5.66 but PC9800 subarch is still non-buildable.
> | Also this is one big hack and only half-merged.
> | 
> 
> It's fairly simple to make it buildable, but it's still a hack
> that no one seems to want to support, so I agree, kill it.
> 
> Can we kill the rest of it too?

What's the opinion of the PC-9800 people regarding this issue?

Is there any work done now or in the near future on the PC-9800 port?

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

