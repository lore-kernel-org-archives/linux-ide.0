From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: 2.6.22 libata spindown
Date: Fri, 1 Jun 2007 22:55:56 +0200
Message-ID: <4ac8254d0706011355y71f9c0b1q237617c6c0fb89c7@mail.gmail.com>
References: <4ac8254d0706011314g5468f02m3cf5a5281bd30018@mail.gmail.com>
	 <4660841D.5050003@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:41166 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764630AbXFAUz5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Jun 2007 16:55:57 -0400
Received: by wx-out-0506.google.com with SMTP id t15so624901wxc
        for <linux-ide@vger.kernel.org>; Fri, 01 Jun 2007 13:55:57 -0700 (PDT)
In-Reply-To: <4660841D.5050003@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On 6/1/07, Jeff Garzik <jeff@garzik.org> wrote:
> Tuncer Ayaz wrote:
> > I'm still seeing the libata warning that disks were not spun down
> > properly on the following two setups and am wondering whether I need
> > a new shutdown binary or the changeset mentioned below is not meant
> > to fix what I'm triggering by halt'ing.
> >
> > If it's not a bug I will try to update my shutdown utility and if
> > that does not work I promise not to bother lkml about a problem
> > caused by my userland. If it is a bug I hope it will be of interest
> > for 2.6.22 bug tracking.
> >
> > Setup 1:
> > SATA 1 Disks
> > AMD64 3200+
> > nVidia nForce 3 250 (Ultra?)
> > Debian i386 Unstable
> >
> > Setup 2:
> > SATA 2 disks
> > Core 2 Duo E6600
> > Intel 975X
> > Debian x86_64 Unstable
> >
> > Just to be clear what warning I'm talking about:
> > DISK MIGHT NOT BE SPUN DOWN PROPERLY. UPDATE SHUTDOWN UTILITY
> > For more info, visit http://linux-ata.org/shutdown.html
>
>
> IIRC, Debian was the one OS that really did need a shutdown utility
> update, as the message says :)

Thanks for the confirmation.
