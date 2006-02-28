From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 28 Feb 2006 09:57:31 -0700
Message-ID: <311601c90602280857x3f102af5l31c9a0ac1a896b4e@mail.gmail.com>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <4401122A.3010908@rtr.ca>
	 <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca>
	 <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
	 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com>
	 <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:48200 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751820AbWB1Q5d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 11:57:33 -0500
Received: by pproxy.gmail.com with SMTP id s49so916897pyc
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 08:57:33 -0800 (PST)
In-Reply-To: <44046D86.7050809@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>

those drives should support all FUA opcodes properly, both queued and unqueued

On 2/28/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Mark Lord wrote:
> > David Greaves wrote:
> >
> >>
> >> scsi1 : sata_sil
> >>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
> >>   Type:   Direct-Access                      ANSI SCSI revision: 05
> >>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
> >>   Type:   Direct-Access                      ANSI SCSI revision: 05
> >
> >
> > I wonder if the non-FUA component here is the sata_sil,
> > rather than the two Maxtor drives.
> >
> > Also, your drives have different firmware,
> > but both have trouble with FUA here.
>
> sata_sil is indeed a piece of hardware that needs to know the opcodes
> ahead of time...
>
>         Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
