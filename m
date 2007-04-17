From: emisca <emisca.ml@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Tue, 17 Apr 2007 09:00:33 +0200
Message-ID: <414cba4e0704170000j9ad6156o256ad40e98f7f3ba@mail.gmail.com>
References: <461D4E2C.6000704@redhat.com> <20070414105255.GB9157@ucw.cz>
	 <20070415155343.GA12069@khazad-dum.debian.net>
	 <Pine.LNX.4.61.0704152050150.27018@yvahk01.tjqt.qr>
	 <4623F804.3020405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:20084 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbXDQHAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 03:00:35 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1730281wra
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2007 00:00:34 -0700 (PDT)
In-Reply-To: <4623F804.3020405@redhat.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

2007/4/17, Chuck Ebbert <cebbert@redhat.com>:
> Jan Engelhardt wrote:
> > On Apr 15 2007 12:53, Henrique de Moraes Holschuh wrote:
> >> On Sat, 14 Apr 2007, Pavel Machek wrote:
> >>> How common are notebooks that cut power to disks during reboot?
> >> Assuming it also does this when running Windows, I'd report it as a grave
> >> bug to the vendor and demand it to be fixed, or the machine to be exchanged
> >> with another model that doesn't have this defect.
> >
> > Given that it does not happen on Windows (IIRC Chuck's post),
> > then just what is Windows [not] doing that Linux does?
>
> It looks like there are two problems here:
>
> (1) Some notebooks power off and back on when restarting.
>     Both Linux and other OS handle that badly because they
>     assume power is not interrupted on reboot. The noise
>     emitted is relatively loud.
>

I'm affected by this problem, hp nx7400 + Seagate Momentus 5400.3 160gb SATA

When "drive spins down, acpi_power_off is written on the console, the
drive spins up again, and 3-4 seconds later the notebook is powered
off, leaving disk heads not parked I think.

I've not tried any new kernel or patches. I'm using stock debian Etch
kernel 2.6.18-5-686.
