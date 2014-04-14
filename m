From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
Date: Mon, 14 Apr 2014 20:44:55 +0200
Message-ID: <20140414204455.5d83513d@skate>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<16639486.i0jTGsaDYr@amdc1032>
	<20140414180142.0dd63a1f@skate>
	<10589751.qhi630WAFs@amdc1032>
	<20140414181920.1e309019@skate>
	<20140414174606.GB10416@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34295 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754574AbaDNSo7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 14:44:59 -0400
In-Reply-To: <20140414174606.GB10416@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear Tejun Heo,

On Mon, 14 Apr 2014 13:46:06 -0400, Tejun Heo wrote:

> > Well, I wasn't planning on re-spinning just to add Acked-by/Reviewed-by
> > tags, as those are generally added by the subsystem maintainers when
> > applying the patches. Though if Tejun says otherwise, I can definitely
> > re-spin without any problem.
> > 
> > Tejun, just let me know what you prefer.
> 
> I can collect the -by's but better patch description is always nice.
> Maybe just update the patch description and post that one as reply to
> the patch posted in this thread?

Actually, Bartlomiej wanted the comment about the power management
features to be made in the code itself, rather than in the commit log,
so I guess I'll just respin the patch series. Expect a v3 tomorrow with
this change.

> Also, how do you want the patches to be routed?  Can all go through libata?

As written in the cover letter, I'd expect patches 1 and 2 to go
through libata, and then patches 3, 4 and 5 to go through arm-soc. The
reason is that patches 3, 4 and 5 modifies the Device Tree files and
the ARM defconfigs, which are likely to also be changed by other
commits in the same cycle. However, the DT binding documentation change
and the driver change are independent, so they can go through libata.

I guess Jason Cooper, who handles the patch merging for mvebu
platforms, can confirm (or not?) this proposal.

Thanks a lot for the feedback!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
