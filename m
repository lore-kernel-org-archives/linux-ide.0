From: Jochen Heuer <jogi-kernel@planetzork.ping.de>
Subject: Re: Bug or HW? ata1: command timeout, stat 0x50 host_stat 0x4
Date: Wed, 5 Jul 2006 00:24:51 +0200
Message-ID: <20060704222451.GA6041@planetzork.ping.de>
References: <20060702000706.GA11103@planetzork.ping.de> <44AA89CF.7000404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lilly.ping.de ([83.97.42.2]:44037 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id S932252AbWGDW3p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jul 2006 18:29:45 -0400
Content-Disposition: inline
In-Reply-To: <44AA89CF.7000404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Tue, Jul 04, 2006 at 11:31:27AM -0400, Mark Lord wrote:
> Jochen Heuer wrote:
> >On Wed, Jun 28, 2006 at 10:09:12AM +0200, Jochen Heuer wrote:
> ..
> >also not increasing ... Are there any known issues in this area with SMP
> >kernels?
> 
> Mmm.. there was another thread in lkml about the A8V, where somebody
> reported that turning *off* CONFIG_PREEMPT results in much more stable
> libata operation for some users.

Ok, I will test this! And thanks for the info.

Best regards,

   Jochen

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
