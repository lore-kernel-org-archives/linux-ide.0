From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Regression bug - Random SATA drives on PMPs on sata_sil24 cards
 not being detected at boot with 3.2, 3.4, 3.6
Date: Mon, 10 Sep 2012 01:27:39 -0700
Message-ID: <CAMHSBOVgw-DWYWvckwUNN7o4Qeq_q-omGAUL2XnWtOznWWDz3g@mail.gmail.com>
References: <CAHnuAexq=R12+hv+XkL5b+qh6RYKXKVG8M6YX5sjbVSbEne6zA@mail.gmail.com>
	<CAHnuAezw5KFykmiS=nLfY_v_gac_Yau3akMxWYbLUYyUC99sXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51679 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab2IJI1k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Sep 2012 04:27:40 -0400
Received: by qcro28 with SMTP id o28so839772qcr.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Sep 2012 01:27:39 -0700 (PDT)
In-Reply-To: <CAHnuAezw5KFykmiS=nLfY_v_gac_Yau3akMxWYbLUYyUC99sXg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Smedegaard Buus <danielbuus@gmail.com>
Cc: linux-ide@vger.kernel.org

Daniel,

I work issues related to port multiplier and Sil controllers. I would
like to get more info:
I already have the dmesg. from bug/987353 [kernel 3.2.0]
- Can you include dmesg using 3.0.0-17-generic
- Can you include dmesg when you hotplug the disks with 3.2.0

My patches fix staggered spinup and allow more time for recovery, but
also cause system to boot more slowly - see thread
"http://www.spinics.net/lists/linux-ide/msg41700.html"

Gwendal.
On Fri, Sep 7, 2012 at 6:59 AM, Daniel Smedegaard Buus
<danielbuus@gmail.com> wrote:
> Hello good folks :)
>
> Don't know what the right way to  report this is, but I was told in
> the thread at buzilla.kernel.org
> (https://bugzilla.kernel.org/show_bug.cgi?id=43153) to post my bug
> here.
>
> Basically, here's what I wrote in that bug report:
>
> ==
>
> Hi :)
>
> I originally reported this to the Ubuntu kernel bugzilla
> (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/987353) and was directed
> here.
>
> Since switching my Kubuntu system from Oneiric (kernel 3.0) to Precise daily
> (kernel 3.2), GRUB will hang for a minute or more immediately after boot
> selection while (according to dmesg) hard resetting the links on my sata_sil24
> based PCIe controllers that have 1:5 port multipliers attached to them.
>
> Eventually it will semi-succeed and continue booting, but I'll be missing one
> or two SATA drives until I manually hotplug them out and back in, at which
> point they'll function normally (AFAICT - I haven't really stress-tested this,
> but at least they're all present and seem to work without issues).
>
> The box in question (amd64) has 22 SATA drives,
> 6 on ICH10R
> 15 on three sata_sil24 PCIe 1-port cards using three 1:5 PMPs
> 1 on a sata_sil PCI32 4-port card
>
> There is no fakeraid configured.
>
> The problem showed with the kernel shipped with the Precise daily build I
> installed, 3.2.0-23-generic. I installed 3.4.0-030400rc4-generic from
> http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.4-rc4-precise/ which didn't
> help, and then reverted to 3.0.0-17-generic, which resolved the issue
> immediately.
>
> I'll attach some files for reference (all from the 3.2 configuration - there
> are more at the Ubuntu link previously mentioned, not sure which are relevant
> to you), please let me know if I should provide or do anything else.
>
> Thanks for your time and effort,
> Daniel :)
>
> ==
>
> ...and...
>
> ==
>
> diffing the sata_sil24 driver module from 3.0 with the one from 3.3
> doesn't really show any difference AFAICT if you ignore renaming of some
> function calls and a couple of type changes. My C knowledge isn't exactly vast,
> but it'd appear the problem originates elsewhere?
>
> ==
>
> ...and...
>
> ==
>
> Just thought I'd update the bug, adding 3.6 to the list of affected versions as
> I just had a test run on the mainline 3.6 RC3 kernel for Quantal :)
>
> ==
>
> So, anything to do about this? What can I do to help? On the bug
> report page, dmesg, lspci and version info is attached.
>
> Cheers,
> Daniel :)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
