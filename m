From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] ata: add MAINTAINERS entry for libata PATA drivers
Date: Tue, 02 Dec 2014 17:29:07 +0000
Message-ID: <1417541347.3203.77.camel@acox1-desk.ger.corp.intel.com>
References: <27267694.oe0s2nj2E5@amdc1032>
	 <547DF518.20104@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32773 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648AbaLBR3K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Dec 2014 12:29:10 -0500
In-Reply-To: <547DF518.20104@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-ide@vger.kernel.org

On Tue, 2014-12-02 at 20:21 +0300, Sergei Shtylyov wrote:
> On 12/02/2014 07:29 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> > Add myself as the primary maintainer for libata PATA drivers.
> 
> > The merging process would remain unchanged with patches going
> > through Tejun's tree.
> 
> > Cc: Alan Cox <alan@linux.intel.com>
> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > If people are fine with it I would like to more officially take
> > care of the libata PATA drivers.
> 
> >   MAINTAINERS |    8 ++++++++
> >   1 file changed, 8 insertions(+)
> 
> > Index: b/MAINTAINERS
> > ===================================================================
> > --- a/MAINTAINERS	2014-12-02 16:48:28.932973963 +0100
> > +++ b/MAINTAINERS	2014-12-02 16:58:35.532969351 +0100
> > @@ -7116,6 +7116,14 @@ F:	drivers/video/fbdev/sti*
> >   F:	drivers/video/console/sti*
> >   F:	drivers/video/logo/logo_parisc*
> >
> > +PATA LIBATA DRIVERS
> > +M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > +M:	Tejun Heo <tj@kernel.org>
> > +L:	linux-ide@vger.kernel.org
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
> > +S:	Supported
> > +F:	drivers/ata/pata_*.c
> > +
> 
>     What about ata_{generic|piix}.c? Those are PATA as well as SATA...

ata_piix is maintained (as such as it needs to be) by Intel and pretty
much every change in recent history is SATA.

ata_generic is a good point.


