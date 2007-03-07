From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Libata Pass Through PIO Multi Support
Date: Wed, 7 Mar 2007 16:00:56 -0700
Message-ID: <8202f4270703071500u789ab61at8d173b97486339ee@mail.gmail.com>
References: <8202f4270703071357h1020d9bam511891325c4b0117@mail.gmail.com>
	 <45EF3DBF.1010400@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:61936 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965714AbXCGXA5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 18:00:57 -0500
Received: by wr-out-0506.google.com with SMTP id 58so539834wri
        for <linux-ide@vger.kernel.org>; Wed, 07 Mar 2007 15:00:56 -0800 (PST)
In-Reply-To: <45EF3DBF.1010400@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 3/7/07, Jeff Garzik <jeff@garzik.org> wrote:
> Fajun Chen wrote:
> > Hi Folks,
> >
> > In ata_scsi_pass_thru() function in libata-scsi.c, the following code
> > is in place:
> >        if (scsicmd[1] & 0xe0)
> >                /* PIO multi not supported yet */
> >                goto invalid_fld;
> > Could someone explain why the PIO multi is not supported in libata pass
> > through?
>
> That's just code left over from before we merged Albert Lee's patches
> adding PIO-multi support.  That check should probably just be removed.
>

Could you please provide a pointer to Albert Lee's PIO multi patch?
I'm not sure if 2.6.18-rc2 with libata 2.00 has already got the patch.

Thanks,
Fajun
