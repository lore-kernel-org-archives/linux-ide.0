From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
Date: Mon, 14 Apr 2014 13:46:06 -0400
Message-ID: <20140414174606.GB10416@htj.dyndns.org>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <16639486.i0jTGsaDYr@amdc1032>
 <20140414180142.0dd63a1f@skate>
 <10589751.qhi630WAFs@amdc1032>
 <20140414181920.1e309019@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:64469 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbaDNRqK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 13:46:10 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so9344485qcx.10
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2014 10:46:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140414181920.1e309019@skate>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 14, 2014 at 06:19:20PM +0200, Thomas Petazzoni wrote:
> Dear Bartlomiej Zolnierkiewicz,
> 
> On Mon, 14 Apr 2014 18:13:07 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, April 14, 2014 06:01:42 PM Thomas Petazzoni wrote:
> > > Dear Bartlomiej Zolnierkiewicz,
> > > 
> > > On Mon, 14 Apr 2014 17:53:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > > >  * Fixed the module alias name. Suggested by Bartlomiej
> > > > >    Zolnierkiewicz.
> > > > 
> > > > Well, you could have also added a comment explaining the lack of
> > > > the Power Management support..
> > > 
> > > True, sorry for this. Should I resend a new version of the patch series
> > > with an indication about this in the commit log? Or is this OK as it is?
> > 
> > Please include the comment in the next revision if this is not too much
> > trouble (I assume that you would like to do another re-spin just to add
> > Acked-by/Reviewed-by tags anyway).
> 
> Well, I wasn't planning on re-spinning just to add Acked-by/Reviewed-by
> tags, as those are generally added by the subsystem maintainers when
> applying the patches. Though if Tejun says otherwise, I can definitely
> re-spin without any problem.
> 
> Tejun, just let me know what you prefer.

I can collect the -by's but better patch description is always nice.
Maybe just update the patch description and post that one as reply to
the patch posted in this thread?  Also, how do you want the patches to
be routed?  Can all go through libata?

-- 
tejun
