From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Fri, 13 Apr 2007 21:42:29 +0200
Message-ID: <200704132142.29582.bzolnier@gmail.com>
References: <461D4E2C.6000704@redhat.com> <Pine.LNX.4.61.0704112347230.20436@yvahk01.tjqt.qr> <461D5C24.9080506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:13814 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398AbXDMTdz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 15:33:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so608030uga
        for <linux-ide@vger.kernel.org>; Fri, 13 Apr 2007 12:33:53 -0700 (PDT)
In-Reply-To: <461D5C24.9080506@redhat.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Thursday 12 April 2007, Chuck Ebbert wrote:
> Jan Engelhardt wrote:
> > On Apr 11 2007 17:35, Chuck Ebbert wrote:
> >> Jan Engelhardt wrote:
> >>> On Apr 11 2007 17:07, Chuck Ebbert wrote:
> >>>> When I reboot my notebook, it powers off and powers back on.
> >>>> On poweroff a loud snapping noise seems to be coming from the
> >>>> hard drive. Today I noticed there is no "shutdown: hda" on
> >>>> the console when I reboot. Whne I do a normal poweroff the
> >>>> message is displayed and there is no noise. Should the IDE
> >>>> code be changed so it always shuts down the drive?
> >>> What sort of notebook? What sort of harddisk?
> >> Compaq Presario V2000 series, with a new Seagate ST9120821A
> >> 120GB 5400RPM drive.
> > 
> > I specifically hoped you might have a TOSHIBA MK2003GAH,
> > which does a hard unload when left idle for too long.
> > 
> > Only on reboots huh?
> > 
> > What happens if you reboot another OS, freebsd f.ex.? (You can try that off
> > CD1)
> 
> Now we're getting somewhere. There is some other OS on here because
> it's required for doing BIOS updates. I booted it and shut down.
> The power cycle count increased but the power off retract count did not.
> 
> The counts are:
> 
> power cycle ... 111
> power off retract ... 92
> 
> The difference is now 19; it was 18 before.

Is the noise present if you reboot the other OS?
Does it result in Power-Off_Retract count increase?

Bart
