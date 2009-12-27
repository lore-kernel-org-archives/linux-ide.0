From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Long delays while hibernating
Date: Sun, 27 Dec 2009 15:09:27 +0100
Message-ID: <200912271509.27770.rjw@sisk.pl>
References: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com> <200912262221.57781.rjw@sisk.pl> <74fd948d0912261435h7f142cd2k1015f25526e0addb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59811 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbZL0OI6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Dec 2009 09:08:58 -0500
In-Reply-To: <74fd948d0912261435h7f142cd2k1015f25526e0addb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Saturday 26 December 2009, Pedro Ribeiro wrote:
> On Sat, Dec 26, 2009 at 9:21 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday 26 December 2009, Pedro Ribeiro wrote:
> >> On Sat, Dec 26, 2009 at 1:26 AM, Tejun Heo <tj@kernel.org> wrote:
> >> > (cc'ing Rafael)
> >> >
> >> > On 12/26/2009 03:10 AM, Pedro Ribeiro wrote:
> >> >>> Oh... Can you please try this one then?
> >> >>
> >> >> Sorry, still hangs with this patch :(
> >> >>
> >> >> This only happens in hibernation... suspend is fine.
> >> >
> >> > Hmmm... the patch does apply to both suspend and hibernation.  Rafael,
> >> > Pedro's ThinkPad T400 burns cpu cycle for 30secs on "Atomic
> >> > copy/restore" step of hibernation if the ultrabay is powered off.  The
> >> > original report can be found at...
> >> >
> >> >  http://thread.gmane.org/gmane.linux.ide/44190
> >> >
> >> > Please note that it's with TuxOnIce patches.  Anyways, ata_piix on
> >> > certain configurations have similar issues where after the OS is done
> >> > suspending and powering off the piix controller, the BIOS tries to
> >> > access it and ends up burning cpu cycles which can be worked around by
> >> > leaving the controller on after suspend.  Applying the same workaround
> >> > didn't resolve the issue.  Do you know what can make cpu burn for
> >> > 30secs on the atomic copy/restore step?
> >
> > No idea.
> >
> > Is this reproducible with /sys/power/pm_test = core?
> >
> > [If you echo "core" to /sys/power/pm_test and then attempt to hibernate,
> > it should just simulate snapshotting the system, sleep for 5 seconds and go
> > back to your command prompt (or wherever you started the "hibernation").]
> >
> >> > Pedro, can you please try to reproduce the problem without TuxOnIce
> >> > patches?
> >> >
> >> > Thanks.
> >> >
> >> > --
> >> > tejun
> >> >
> >>
> >> Hi Rafael and Tejun,
> >>
> >> I am experiencing the same delay with the kernel swsusp, so this is
> >> definitely not a TuxOnIce issue.
> >
> > I don't think this can be a TuxOnIce.  Most likely, ACPI is trying to do
> > something stupid in _PTS.
> >
> > Rafael
> >
> 
> Hi,
> 
> The issue also occurs with pm_test.
> Attached are two files, the one ending with "ok" shows a good pm_test
> cycle, with the ultrabay powered on. The one ending in "bad" shows the
> bad pm_test cycle with a 30 second delay between:
> 
> [  545.764159] ACPI: Waking up from system sleep state S4
> [  575.844179] ACPI: \_SB_.PCI0.SATA.PRT1 - docking
> (lines 48/49)
> 
> Please let me know how I can assist you.

Please echo "shutdown" to /sys/power/disk and rerun the test with
/sys/power/pm_test = core.

Rafael
