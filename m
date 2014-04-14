From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
Date: Mon, 14 Apr 2014 18:01:42 +0200
Message-ID: <20140414180142.0dd63a1f@skate>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<16639486.i0jTGsaDYr@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33084 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753668AbaDNQBq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 12:01:46 -0400
In-Reply-To: <16639486.i0jTGsaDYr@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear Bartlomiej Zolnierkiewicz,

On Mon, 14 Apr 2014 17:53:37 +0200, Bartlomiej Zolnierkiewicz wrote:

> >  * Fixed the module alias name. Suggested by Bartlomiej
> >    Zolnierkiewicz.
> 
> Well, you could have also added a comment explaining the lack of
> the Power Management support..

True, sorry for this. Should I resend a new version of the patch series
with an indication about this in the commit log? Or is this OK as it is?

Note that working on power management support is part of our mid-term
TODO list for this platform, so it will not remain unimplemented
forever.

> Anyway, all patches look OK to me.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
