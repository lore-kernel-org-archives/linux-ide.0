From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Regression bug - Random SATA drives on PMPs on sata_sil24 cards
 not being detected at boot with 3.2, 3.4, 3.6
Date: Mon, 10 Sep 2012 11:44:08 -0700
Message-ID: <CAMHSBOWkT3QXP13BUu6uTd35+tdHok0mnOeh6Vc1ctLr=FBGQg@mail.gmail.com>
References: <CAHnuAexq=R12+hv+XkL5b+qh6RYKXKVG8M6YX5sjbVSbEne6zA@mail.gmail.com>
	<CAHnuAezw5KFykmiS=nLfY_v_gac_Yau3akMxWYbLUYyUC99sXg@mail.gmail.com>
	<CAMHSBOVgw-DWYWvckwUNN7o4Qeq_q-omGAUL2XnWtOznWWDz3g@mail.gmail.com>
	<CAHnuAexzgVCRkWCfE6udGn3ugAUcC9P_Q2=yY4vt2y4Yrj3knQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53963 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab2IJSoJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Sep 2012 14:44:09 -0400
Received: by qaas11 with SMTP id s11so947227qaa.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Sep 2012 11:44:08 -0700 (PDT)
In-Reply-To: <CAHnuAexzgVCRkWCfE6udGn3ugAUcC9P_Q2=yY4vt2y4Yrj3knQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Smedegaard Buus <danielbuus@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, Sep 10, 2012 at 4:16 AM, Daniel Smedegaard Buus
<danielbuus@gmail.com> wrote:
> On Mon, Sep 10, 2012 at 10:27 AM, Gwendal Grignou <gwendal@google.com> wrote:
>>
>> Daniel,
>>
>
> Hi Gwendal :)
>
>>
>> I work issues related to port multiplier and Sil controllers. I would
>> like to get more info:
>> I already have the dmesg. from bug/987353 [kernel 3.2.0]
>> - Can you include dmesg using 3.0.0-17-generic
>> - Can you include dmesg when you hotplug the disks with 3.2.0
>>
>
> Definitely! I'm currently running "3.0.0-24-server #40-Ubuntu SMP Tue
> Jul 24 15:56:43 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux". Not sure if
> that one is alright for the former output?
It is fine.
>
> Also, would getting kernels from
> http://kernel.ubuntu.com/~kernel-ppa/mainline/ be the way to go? And
> if so, should I get 3.0.0 or 3.0.17, as they don't seem to be using
> the same versioning numbers as the Ubuntu-supplied kernels? Or should
> I just use kernels from the Ubuntu repositories?
I just want to compare when it works for you [kernel ~ 3.0.. and when
it does not work kernel ~ 3.2...]
Although, when you are testing, you must power down all the disks and
server. The timing is very different between cold boot and warm boot.
>
>>
>> My patches fix staggered spinup and allow more time for recovery, but
>> also cause system to boot more slowly - see thread
>> "http://www.spinics.net/lists/linux-ide/msg41700.html"
>>
>
> Right, could be related. You may have noticed from the dmesg that I've
> also forced 1.5 Gbps speeds on the channels on my PMPs. Otherwise they
> won't be stable, especially when a sector error is encountered. The
> port resetting will take down the entire group of drives on the PMP
> leading to data read errors on my ZFS pool. May be related also. Just
> laying it out there :)
That's a separate issue, sector [read] error should not trigger PMP resets.
Link issues between the host and the PMP are hard to handle. The host
has to reset the link to the PMP and therefore you can not access all
the disks behind for a while. Although cheap, we found PMPs errors are
hard to manage. Investing in a SAS controller - or SATA controller
with high count ports will improve the performance [1.5Gps for 5
drives will be a bottleneck when reconstructing for instance.]

>
> Thanks,
> Daniel
>
>> Gwendal.
>> On Fri, Sep 7, 2012 at 6:59 AM, Daniel Smedegaard Buus
>> <danielbuus@gmail.com> wrote:
>> > Hello good folks :)
>> >
>> > Don't know what the right way to  report this is, but I was told in
>> > the thread at buzilla.kernel.org
>> > (https://bugzilla.kernel.org/show_bug.cgi?id=43153) to post my bug
>> > here.
>> >
>> > Basically, here's what I wrote in that bug report:
>> >
>> > ==
>> >
>> > Hi :)
>> >
>> > I originally reported this to the Ubuntu kernel bugzilla
>> > (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/987353) and was directed
>> > here.
>> >
>> > Since switching my Kubuntu system from Oneiric (kernel 3.0) to Precise daily
>> > (kernel 3.2), GRUB will hang for a minute or more immediately after boot
>> > selection while (according to dmesg) hard resetting the links on my sata_sil24
>> > based PCIe controllers that have 1:5 port multipliers attached to them.
>> >
>> > Eventually it will semi-succeed and continue booting, but I'll be missing one
>> > or two SATA drives until I manually hotplug them out and back in, at which
>> > point they'll function normally (AFAICT - I haven't really stress-tested this,
>> > but at least they're all present and seem to work without issues).
>> >
>> > The box in question (amd64) has 22 SATA drives,
>> > 6 on ICH10R
>> > 15 on three sata_sil24 PCIe 1-port cards using three 1:5 PMPs
>> > 1 on a sata_sil PCI32 4-port card
>> >
>> > There is no fakeraid configured.
>> >
>> > The problem showed with the kernel shipped with the Precise daily build I
>> > installed, 3.2.0-23-generic. I installed 3.4.0-030400rc4-generic from
>> > http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.4-rc4-precise/ which didn't
>> > help, and then reverted to 3.0.0-17-generic, which resolved the issue
>> > immediately.
>> >
>> > I'll attach some files for reference (all from the 3.2 configuration - there
>> > are more at the Ubuntu link previously mentioned, not sure which are relevant
>> > to you), please let me know if I should provide or do anything else.
>> >
>> > Thanks for your time and effort,
>> > Daniel :)
>> >
>> > ==
>> >
>> > ...and...
>> >
>> > ==
>> >
>> > diffing the sata_sil24 driver module from 3.0 with the one from 3.3
>> > doesn't really show any difference AFAICT if you ignore renaming of some
>> > function calls and a couple of type changes. My C knowledge isn't exactly vast,
>> > but it'd appear the problem originates elsewhere?
>> >
>> > ==
>> >
>> > ...and...
>> >
>> > ==
>> >
>> > Just thought I'd update the bug, adding 3.6 to the list of affected versions as
>> > I just had a test run on the mainline 3.6 RC3 kernel for Quantal :)
>> >
>> > ==
>> >
>> > So, anything to do about this? What can I do to help? On the bug
>> > report page, dmesg, lspci and version info is attached.
>> >
>> > Cheers,
>> > Daniel :)
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
