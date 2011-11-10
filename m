From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH] libata-pmp: add schedule timeout to support some PMP
 cards
Date: Thu, 10 Nov 2011 08:07:47 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11617501@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1320033440-1106-1-git-send-email-r66093@freescale.com>
 <20111103160759.GI4417@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:34918 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933957Ab1KJIHx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2011 03:07:53 -0500
In-Reply-To: <20111103160759.GI4417@google.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
> owner@vger.kernel.org] On Behalf Of Tejun Heo
> Sent: Friday, November 04, 2011 12:08 AM
> To: Huang Changming-R66093
> Cc: linux-ide@vger.kernel.org
> Subject: Re: [PATCH] libata-pmp: add schedule timeout to support some
> PMP cards
> 
> Hello,
> 
> On Mon, Oct 31, 2011 at 11:57:20AM +0800, r66093@freescale.com wrote:
> > From: Jerry Huang <r66093freescale.com>
> >
> > With Freescale SATA controller, some PMP cards(e.g JMB393 PMP card)
> > can't work on some platforms (e.g mpc837x, p1022):
> > During PMP initialize, when reading the PMP SCR, we will observe the
> > TIMEOUT error because PMP card SCR is not ready.
> > Therefore, we need enough time to wait for the PMP card ready for SCR
> read:
> > 1. read the SCR after 1ms sleep,
> > 2. if failed, looping until read success or timeout (count = 0)
> ...
> > diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index
> > 224faab..18d5f8e 100644
> > --- a/drivers/ata/libata-pmp.c
> > +++ b/drivers/ata/libata-pmp.c
> > @@ -140,11 +140,19 @@ int sata_pmp_qc_defer_cmd_switch(struct
> > ata_queued_cmd *qc)  int sata_pmp_scr_read(struct ata_link *link, int
> > reg, u32 *r_val)  {
> >  	unsigned int err_mask;
> > +	int count = 20;	/* try 20 times */
> >
> >  	if (reg > SATA_PMP_PSCR_CONTROL)
> >  		return -EINVAL;
> >
> > -	err_mask = sata_pmp_read(link, reg, r_val);
> > +	do {
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		schedule_timeout(1 * HZ / 1000); /* sleep 1 msecond */
> > +		set_current_state(TASK_RUNNING);
> > +
> > +		err_mask = sata_pmp_read(link, reg, r_val);
> > +	} while ((count--) && err_mask);
> 
> Ummm... We can't really issue commands after failure without going
> through recovery.  For ahci, it probably works.  For other controllers,
> it may not.  Where does this delay come from?  Is there any other way
> to wait for device readiness?
> 
It is very bad. 
I have two PMP cards, one (5 ports) can work well without the delay time before reading PMP SCR, but the other (15 ports) must delay enough time before reading the PMP SCR.
It seems there is no other way to detect the device readiness.

Maybe I will just delay some time before send SCR command, if it failed, then we will report this error to driver?

Thanks and Best Regards
Jerry Huang

