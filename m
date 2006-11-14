From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Date: Tue, 14 Nov 2006 13:29:14 +0100
Message-ID: <20061114122914.GD22178@kernel.dk>
References: <20061030114503.GW4563@kernel.dk> <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com> <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org> <45533468.1060400@gmail.com> <806dafc20611091209s5864c9eam77a9290194de343d@mail.gmail.com> <20061110161510.GC15031@kernel.dk> <4554A681.2000502@ens-lyon.org> <20061110162330.GE15031@kernel.dk> <4559B580.3070201@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:17940 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965368AbWKNM0g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 07:26:36 -0500
Content-Disposition: inline
In-Reply-To: <4559B580.3070201@ens-lyon.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Monty Montgomery <monty@xiph.org>, Tejun Heo <htejun@gmail.com>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Douglas Gilbert <dougg@torque.net>

On Tue, Nov 14 2006, Brice Goglin wrote:
> I just tried commit 616e8a091a035c0bd9b871695f4af191df123caa on top of
> rc5 just in case. This commit fixes
> http://lkml.org/lkml/2006/10/13/100, which looks related. And it
> actually appears to fix our freeze too. Does this speak to you guys ?

I thought you had already tested that? Well that's good news, so it was
a similar bug after all. Another one closed for 2.6.19.

-- 
Jens Axboe

