From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Fri, 13 Apr 2007 22:47:48 +0200
Message-ID: <58cb370e0704131347qa3439b5u26c8532deac50cd2@mail.gmail.com>
References: <461D4E2C.6000704@redhat.com>
	 <Pine.LNX.4.61.0704112347230.20436@yvahk01.tjqt.qr>
	 <461D5C24.9080506@redhat.com> <200704132142.29582.bzolnier@gmail.com>
	 <461FDBB4.8070208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965292AbXDMUrv@vger.kernel.org>
In-Reply-To: <461FDBB4.8070208@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 4/13/07, Chuck Ebbert <cebbert@redhat.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >> Now we're getting somewhere. There is some other OS on here because
> >> it's required for doing BIOS updates. I booted it and shut down.
> >> The power cycle count increased but the power off retract count did not.
> >>
> >> The counts are:
> >>
> >> power cycle ... 111
> >> power off retract ... 92
> >>
> >> The difference is now 19; it was 18 before.
> >
> > Is the noise present if you reboot the other OS?
> > Does it result in Power-Off_Retract count increase?
>
> There is no noise and the retract count does not increase when I boot
> and then shutdown/power off the other OS.

What about shutdown/reboot?
