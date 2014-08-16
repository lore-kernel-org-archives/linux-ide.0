From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: propagate return value of scc_wait_after_reset
Date: Sat, 16 Aug 2014 08:21:25 -0400
Message-ID: <20140816122125.GD9305@htj.dyndns.org>
References: <1408184238-1733-1-git-send-email-arjun024@gmail.com>
 <20140816113718.GA9305@htj.dyndns.org>
 <CAJFMrCFKEQXn79Piofwi0Ph0bRVJx-uMasYk_RW36Sp0FTKoEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:42409 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbaHPMV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Aug 2014 08:21:28 -0400
Content-Disposition: inline
In-Reply-To: <CAJFMrCFKEQXn79Piofwi0Ph0bRVJx-uMasYk_RW36Sp0FTKoEg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjun Sreedharan <arjun024@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 16, 2014 at 05:34:31PM +0530, Arjun Sreedharan wrote:
> On 16 August 2014 17:07, Tejun Heo <tj@kernel.org> wrote:
> > Hello,
> >
> > On Sat, Aug 16, 2014 at 03:47:17PM +0530, Arjun Sreedharan wrote:
> >> scc_bus_softreset not necessarily should return zero.
> >> Propagate the error code.
> >> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
> >> ---
> >>  drivers/ata/pata_scc.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
> >> index 4e006d7..5618c4518 100644
> >> --- a/drivers/ata/pata_scc.c
> >> +++ b/drivers/ata/pata_scc.c
> >> @@ -585,7 +585,7 @@ static int scc_wait_after_reset(struct ata_link *link, unsigned int devmask,
> >>   *   Note: Original code is ata_bus_softreset().
> >>   */
> >>
> >> -static unsigned int scc_bus_softreset(struct ata_port *ap, unsigned int devmask,
> >> +static int scc_bus_softreset(struct ata_port *ap, unsigned int devmask,
> >>                                        unsigned long deadline)
> >>  {
> >>       struct ata_ioports *ioaddr = &ap->ioaddr;
> >> @@ -599,9 +599,7 @@ static unsigned int scc_bus_softreset(struct ata_port *ap, unsigned int devmask,
> >
> > scc_bus_softreset() should return int too, right?
> 
> I have changed it from unsigned int to int for better clarity since
> scc_wait_after_reset() could
> return negative errnos. Any issues ??

Oh, I missed the previous chunk which changes it from uint to int.
Sorry about that.

Thanks.

-- 
tejun
