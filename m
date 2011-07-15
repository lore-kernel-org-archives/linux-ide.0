From: Marc MERLIN <marc@merlins.org>
Subject: Re: sata_mv WARNING: at drivers/ata/libata-sff.c:1322
Date: Fri, 15 Jul 2011 08:55:20 -0700
Message-ID: <20110715155520.GB25319@merlins.org>
References: <4E076E9E.9080400@pobox.com> <20110629034125.GC32153@merlins.org> <4E0AA1C1.6020406@pobox.com> <20110629050341.GB10580@merlins.org> <20110629150713.GG10580@merlins.org> <4E0B4CC7.5000601@pobox.com> <20110712142938.GB4347@mtj.dyndns.org> <CAMHSBOWrU0MRuDOvAsU-=hqZnZrRp2ry6zvYTH0M8kwXfopryQ@mail.gmail.com> <4E1E1F12.8040100@pobox.com> <CAMHSBOU+XHaFn_HtDTdvPr-sHEGS9MsYgCG9dUk71hLZJDaRow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:36013 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab1GOPzh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jul 2011 11:55:37 -0400
Content-Disposition: inline
In-Reply-To: <CAMHSBOU+XHaFn_HtDTdvPr-sHEGS9MsYgCG9dUk71hLZJDaRow@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Mark Lord <mlord@pobox.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

On Thu, Jul 14, 2011 at 12:19:16AM -0700, Gwendal Grignou wrote:
> Mark,
> 
> How PMP support with sata_mv broken for you? I am using marvell 7042
> and sil3726 and it works fine, but I am still using 2.6.36.
> 
> Tejun, Marc,
> 
> I think what happen is if a command is canceled while waiting for
> sff_pio_task to fire up, the warning may happen. The following patch
> should fix it. Marc, can you reproduce the problem easily?
> 
> Thanks,
> Gwendal.
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 996a7a5..c24127d 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1333,6 +1333,7 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
> 
>         cancel_delayed_work_sync(&ap->sff_pio_task);
>         ap->hsm_task_state = HSM_ST_IDLE;
> +       ap->sff_pio_task_link = NULL;
> 
>         if (ata_msg_ctl(ap))
>                 ata_port_dbg(ap, "%s: EXIT\n", __func__);

I can confirm this makes the warnings go away, thanks Gwendal.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
