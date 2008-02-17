From: "Richard Liu" <richliu.tw@gmail.com>
Subject: Re: ST31000340NS (1000G) Capacity equal 33MB issue.
Date: Mon, 18 Feb 2008 03:41:07 +0800
Message-ID: <d0d565260802171141r1cfdc78fo63383dd8f6b655f2@mail.gmail.com>
References: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com>
	 <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>
	 <47B499F2.1010306@rtr.ca> <47B5CC39.7020302@rtr.ca>
	 <47B70571.4060303@rtr.ca>
	 <d0d565260802170721r34ad933blabb3745691a6a3e9@mail.gmail.com>
	 <47B88881.40003@rtr.ca> <47B88A76.7070601@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:25195 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbYBQTlI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 14:41:08 -0500
Received: by an-out-0708.google.com with SMTP id d31so319966and.103
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 11:41:08 -0800 (PST)
In-Reply-To: <47B88A76.7070601@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Dear Mark:

2008/2/18, Mark Lord <liml@rtr.ca>:
> Mark Lord wrote:
> > Richard Liu wrote:
> ..
> >>   I downloaded hdparm-8.1
> >> and here is output information.
> >>
> >> # ./hdparm -N /dev/sdc
> >>
> >> /dev/sdc:
> >>  max sectors   = 65134/1953525168, HPA is enabled
> > ..
> >
> > Yes, pretty much as expected there.
> >
> > You can safely now try this:
> >
> >    ./hdparm -N1953525168 /dev/sdc
> >
> > If that works, it will have temporarily restored access to the entire
> > drive.
> > Then you can try to make it permanent by doing this:
> >
> >   ./hdparm -Np1953525168 /dev/sdc
> >
> > If *that* also works, then reboot and things should be fine,
> > unless your machine BIOS changes it back again on boot.. :/
> >
> > If either of those *fails*, then it is because your BIOS (or possibly
> > the system startup scripts) have "frozen" the configuration
> > to prevent changes.  Dunno why they would do that, but it's possible.
> >
> > In which case, you could move the drive to another machine temporarily,
> > and then issue that same command there.

I am very appreciate for your help.

Both command
./hdparm -N1953525168 /dev/sdc
and
./hdparm -Np1953525168 /dev/sdc
work fine.

I can get while 1000G disk space.

I tried to read/write some file (around 3G bytes) into the disk.
and uses md5 to verify data.
It seems no problem.

Thank you very much.
> ..
>
> Or just hot unplug/replug the drive and try it again.
> That should also work, assuming the driver for your controller supports hotplug.
>
> Cheers
>
