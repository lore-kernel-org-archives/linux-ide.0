From: "Gwendal Grignou" <gwendal@google.com>
Subject: Re: sata_mv & pmp support
Date: Wed, 16 Apr 2008 00:05:55 -0700
Message-ID: <e7510f760804160005p4590f272pe6bd07836e4a5beb@mail.gmail.com>
References: <47FA4AFF.2010209@gmail.com> <4803C429.6070201@rtr.ca>
	 <4803C850.9010901@rtr.ca> <48040DC8.1050907@gmail.com>
	 <48050904.1040808@rtr.ca> <48050CA1.5010800@rtr.ca>
	 <48052E08.5040306@gmail.com> <480531DB.3020602@rtr.ca>
	 <48055E7C.1060004@rtr.ca> <48056016.6020900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:22567 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbYDPHGB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 03:06:01 -0400
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id m3G75uCJ013660
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 08:05:57 +0100
Received: from wa-out-1112.google.com (wafk17.prod.google.com [10.114.187.17])
	by zps18.corp.google.com with ESMTP id m3G74vU1025974
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 00:05:56 -0700
Received: by wa-out-1112.google.com with SMTP id k17so3344721waf.3
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 00:05:55 -0700 (PDT)
In-Reply-To: <48056016.6020900@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

At reset time, according to the SATA state machine in SATA spec
[16.3.3.5.1] A PM waits for a FIS from the host to port 0xF to be
fully initialized. If for any reason the PM does not issue PHYRDY fast
enough or other problem the host decide there is no device on the
port, it will not issue a FIS, and the PM will never be seen. A PM
will not send asynchronous notification for itself, only to devices
connected to it [and the host controller must be able to handle it].

Maybe polling SATA port could help?

Gwendal.

On Tue, Apr 15, 2008 at 7:10 PM, Tejun Heo <htejun@gmail.com> wrote:
> Mark Lord wrote:
>
> > Mark Lord wrote:
> >
> > >
> > > Yeah, I'm happy now.  :)
> > >
> > > It seems very rock solid, actually, at least on the one PM I have that
> works.
> > > The Fed-Ex guy is due tomorrow with a fresh Marvell PM for me,
> > > but I might send some stuff out for #upstream in the interim.
> > >
> > > Still gotta reboot/retest with a 60x1 chipset first, though.
> > >
> > ..
> >
> > Both command-based and FIS-based switching seem to work just fine.
> > But there is a problem, maybe you could help with ?
> >
> > I've just noticed that, if I unplug/replug the host-side SATA cable
> > on the Sil3726 PM, and *then* "insmod sata_mv", the PM is not found.
> >
> > If I then simply do "rmmod sata_mv ; insmod sata_mv", then the PM is
> found.
> >
> > This happens with the original hardreset code from Jeff,
> > as well as the updated sata_mv code that I've posted earlier.
> > So it is not anything I've broken (recently :) ).
> >
> > Very strange.. I wonder if it also happens with the Marvell PM,
> > except I don't have one here to test with at the moment.
> >
> > Ever heard of anything strange like that?
> >
>
>  IIRC, ICH8 ahci + 4726 fails the initial reset sequence because the PMP
> comes up after the hardreset code times out, which triggers another EH
> iteration which works out fine.  If the problem is caused by the PMP not
> responding fast enough, it should cause a hotplug event afterwards. Maybe
> there's a race condition where hotplug events can be lost?
>
>  --
>  tejun
>
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
