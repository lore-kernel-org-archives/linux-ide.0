From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] libata/sff: Use ops->bmdma_stop instead of
 ata_bmdma_stop()
Date: Tue, 01 Dec 2009 18:29:05 +1100
Message-ID: <1259652545.2076.321.camel@pasglop>
References: <20091201070833.CC084B7BD9@ozlabs.org>
	 <4B14C4DC.6060107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54952 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZLAH3y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 02:29:54 -0500
In-Reply-To: <4B14C4DC.6060107@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org

On Tue, 2009-12-01 at 16:25 +0900, Tejun Heo wrote:
> On 12/01/2009 04:08 PM, Benjamin Herrenschmidt wrote:
> > In libata-sff, ata_sff_post_internal_cmd() directly calls ata_bmdma_stop()
> > instead of ap->ops->bmdma_stop(). This can be a problem for controllers
> > that use their own bmdma_stop for which the generic sff one isn't suitable
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Oh... that's a scary bug lurking around.  Thanks for catching it.
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Feel free to pick that one up earlier if you want (ie for 2.6.32), as
long as we manage to get it in in 2.6.33 -before- I push powerpc-next to
Linus, I'm happy :-) (or we can have it in both trees).

Cheers,
Ben.


