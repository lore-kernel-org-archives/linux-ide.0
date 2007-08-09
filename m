From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: SATA open bugs
Date: Wed, 08 Aug 2007 22:28:40 -0700
Message-ID: <1186637320.3417.0.camel@localhost.localdomain>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:39475 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753755AbXHIF2o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 01:28:44 -0400
In-Reply-To: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Natalie Protasevich <protasnb@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

On Wed, 2007-08-08 at 15:31 -0700, Natalie Protasevich wrote:
> Hi Tejun, Alan, Jeff,
> 
> This is open bug list for SATA subsystem. It has more items than other
> subsystems, but mainly because this is such a hot technology now and
> so much work is being done in this area. Needless to say It is very
> well maintained and exemplary for some other areas that are not that
> lucky...
> Andrew and myself did some initial cleaning and updates but we really
> need your participation and help with the rest.
> Some of open bugs are not actually on this list, only the ones that
> has been quiet for a while or never been looked at.
> Older bugs are probably not really bugs anymore, since SATA has
> changed so much but you can probably clean up this list with good
> guesses about things being fixed or fixed already, or simply too cold
> to keep open.
> 
> Thanks,
> --Natalie
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=8738 adaptec and sata bad interaction

This one's not a bug.  the aic94xx didn't attach to sata devices before
post 2.6.22 by design.  The 2.6.23 rc's should work.

James


