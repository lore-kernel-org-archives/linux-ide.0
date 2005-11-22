From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH, IDE] Blacklist CD-912E/ATK
Date: Tue, 22 Nov 2005 20:26:19 +0000
Message-ID: <1132691179.20233.77.camel@localhost.localdomain>
References: <20051122024426.8C16A34043@koto.vergenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965161AbVKVTyX@vger.kernel.org>
In-Reply-To: <20051122024426.8C16A34043@koto.vergenet.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Horms <horms@verge.net.au>
Cc: Karol Lewandowski <klz@o2.pl>, 340228@bugs.debian.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


>     The drive is clearly broken.  Adding blacklist to drivers/ide/ide-dma.c
>     for this model ("CD-912E/ATK") fixes this problem.

That may be the case but knowing if th drive is the problem is more
tricky.

Firstly try it on a different controller
Secondly check for other firmware revisions 
Thirdly blacklist only your firmware rev if there are others


>     hdc: DMA disabled
>     ------------[ cut here ]------------
>     kernel BUG at drivers/ide/ide-iops.c:949!
>     invalid operand: 0000 [#1]

That is an IDE layer bug not a drive incompatibility. It may be one
triggered the other but until the BUG the kernel was correctly behaving
and had just turned off DMA anyway.
