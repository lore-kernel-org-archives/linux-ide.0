From: "mike zheng" <mail4mz@gmail.com>
Subject: Re: FIS structure and Command List structure for AHCI SATA controller
Date: Thu, 15 Nov 2007 09:49:50 -0500
Message-ID: <5c9cd53b0711150649uddcb5b0p7c3b2fce227a1df3@mail.gmail.com>
References: <5c9cd53b0711081938m1e752087yda930792a57a98c0@mail.gmail.com>
	 <20071109035506.GC25581@havoc.gtf.org>
	 <5c9cd53b0711090539u79c1ba4fte46ee13f5906b42a@mail.gmail.com>
	 <47351F68.3020307@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:11240 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758107AbXKOOtv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 09:49:51 -0500
Received: by py-out-1112.google.com with SMTP id u77so3514572pyb
        for <linux-ide@vger.kernel.org>; Thu, 15 Nov 2007 06:49:50 -0800 (PST)
In-Reply-To: <47351F68.3020307@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

Does kernel2.4 support this chip (Marvell's 88SE6121)? I assume kernel
2.4 supports AHCI device. Is there any patch for this chip I may
apply? And which version of kernel2.4 shall I use?

Thanks for your help,

Mike

On 11/9/07, Jeff Garzik <jeff@garzik.org> wrote:
> mike zheng wrote:
> > Hi Jeff,
> >
> > Actually I am using Marvell's 88SE6121 on kernel 2.4. I just wonder do
> > I have to enable the FIS? The SATA Command Table of the device have
> > following definitions:
> >
> > 00h Command FIS
> > 40h ATAPI Command (CDB)
> > 60h RSVD
> > 80h Physical Region Descriptor Table
> >
> > Does it mean I can only use FIS or ATAPI for this device?
> >
> > Another confusion is the manual say that software should prepare the
> > command header, command FIS and the ATAPI command (CDB) for the ATAPI
> > command. Why it needs the FIS for ATAPI command?
> >
> > Thanks for your help.
>
> FIS == basic data message used by all Serial ATA.
>
> Both SATA ATA and SATA ATAPI use a FIS, it is fundamental to the nature
> of Serial ATA.
>
>        Jeff
>
>
>
>
