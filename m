From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: PATA Sil680 Disabling IRQ
Date: Wed, 27 Feb 2008 17:20:24 -0700
Message-ID: <8202f4270802271620u6cea6176p2bea5ff8e0b9bbef@mail.gmail.com>
References: <8202f4270802261647t505cccf7ra3c81e5fccc9366a@mail.gmail.com>
	 <47C4B5BE.7010709@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:35752 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbYB1AU1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 19:20:27 -0500
Received: by wx-out-0506.google.com with SMTP id h31so3171297wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 16:20:24 -0800 (PST)
In-Reply-To: <47C4B5BE.7010709@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>

On 2/26/08, Jeff Garzik <jeff@garzik.org> wrote:
> Fajun Chen wrote:
> > Hi All,
> >
> > Attached is the source code to Identify Device through sg (courtesy of
> > Mark Lord).  I intentionally change the data transfer from
> > SG_DXFER_FROM_DEV to SG_DXFER_TO_DEV to expose the problem.  When the
> > code is run on SATA Sil3124 controller,  it's working well. But when
> > it is run on PATA Sil680,  IRQ was disabled right away (see dmesg log
> > below). I have a old kernel 2.6.18 rc2 but I suspect the same problem
> > exists in latest kernel release as well.  Please execute above code in
> > your system and see what happens.
>
> root has permission to do anything -- including misprogram the device
> resulting in a lockup / data corruption / nuclear explosion.
>
> We do not work around problems that only present themselves when a
> privileged administrator is doing something really wrong.
>

PIO read/writes with wrong direction is not the only failure mode,
PATA sil680 also failed with disabling IRQ with some unsupported
commands such as Trusted Send (0x5E) even with perfect TF data. Given
that some ATA commands are optional,  we may have a chance to hit the
trap even with well programmed code.

What would take to harden the PATA ISR code such that it fails more gracefully?

Thanks,
Fajun
