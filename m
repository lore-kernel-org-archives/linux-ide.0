From: Priyanka Gupta <ankaguptaca@gmail.com>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Wed, 5 Jan 2011 10:31:48 -0600
Message-ID: <AANLkTik0MZwU2nsYwytr9z3aP7mb3F7_BGZESDOvM=N5@mail.gmail.com>
References: <20110103143947.GS18831@htj.dyndns.org>
	<Pine.LNX.4.44L0.1101031000200.2486-100000@iolanthe.rowland.org>
	<20110103153134.GW18831@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:59489 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1AEQbt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 11:31:49 -0500
Received: by pxi15 with SMTP id 15so2778093pxi.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Jan 2011 08:31:49 -0800 (PST)
In-Reply-To: <20110103153134.GW18831@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org

Tejun,

The patch that I sent does invoke EH, both for resume and suspend. I
am calling ata_pci_device_suspend as the runtime suspend method. This
will call ata_host_suspend which will end up calling
ata_host_request_pm, which sets some flags including
ATA_PFLAG_PM_PENDING and basically schedules the error handling
(ata_port_schedule_eh). Isn't that what is needed?

The runtime resume that I use, does the same - schedules error
handling with ATA_EH_RESET.

Is there any reason that the system suspend and resume methods can't
be used for runtime suspend and resume? I mean sure, we probably don't
need the ata_pci_device_do_suspend part since the runtime PM will take
care of that, but other than that it looks like we should just be able
to do a ata_host_suspend during runtime suspend.

Thanks,
Priyanka

On Mon, Jan 3, 2011 at 9:31 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Alan.
>
> On Mon, Jan 03, 2011 at 10:15:40AM -0500, Alan Stern wrote:
>> > Oh I see. =A0You wanna put the controller into sleep. =A0You'll ha=
ve to
>> > implement EH actions for it and invoke EH to do it. =A0The problem=
 is
>> > that for it to work in generic manner, the operations need to be
>> > synchronized with other accesses to the hardware and going through=
 EH
>> > is the easiest way to achieve that. =A0Something like the followin=
g
>> > would work.
>>
>> Are you talking about the usual SCSI error handler or something else
>> specific to ATA drivers?
>
> I'm talking specifically about libata EH.
>
>> Runtime suspend should not occur unless all the child devices (i.e.,
>> the attached drives) are already suspended. =A0This means it is not
>> necessary to synchronize any operations, since there shouldn't be an=
y
>> other accesses to the hardware going on. =A0Therefore there is no ne=
ed to
>> use the error handler.
>
> Well, it's not that simple I'm afraid. =A0EH actions are asynchronous=
=2E
> Even if all the downstream devices are suspended, PHY events can
> happen any time and EH could be active. =A0Hmmm... a delta but it wou=
ld
> make more sense to put only the controller into hot sleep while
> leaving the disk alone for rotating devices.
>
> Also, on resume, as the controller was out, libata needs to do full
> revalidation & reconfiguration. =A0There's no way to avoid EH.
>
>> > * EH kicks in. =A0Mark the port inactive so that further commands
>> > =A0 processing won't happen (it would probably be nice if this is
>> > =A0 something the PM framework can guarantee but I don't think it'=
s done
>> > =A0 that way, is it?)
>>
>> Why must the port be marked inactive? =A0If any further commands nee=
d to
>> be processed then they should cause the controller to be resumed, at
>> which point the port will be active again.
>
> Then, at least we would need to plug EH because commands aren't the
> only intiation vector.
>
>> > * EH skips all other EH actions and put the controller in sleep.
>>
>> The PCI core already takes care of putting device into D3. =A0The EH
>> doesn't need to do it. =A0And there shouldn't be any other EH action=
s
>> pending.
>
> So, it behaves differently from the usual suspend/resume? =A0We have
> .suspend callback which puts the controller into D3. =A0Are you sayin=
g
> for runtime PM that isn't necessary? =A0If so, wouldn't it be better =
to
> unify behaviors between the two paths?
>
>> > On runtime resume
>> >
>> > * Tell EH to kick in and wake up the controller.
>>
>> The PCI core already puts devices back into D0.
>
> I still can't see how this would work without low level driver's help=
=2E
> Who's gonna reconfigure the controller? =A0Or are controllers suppose=
d
> to maintain all configurations across D3(hot) sleep?
>
>> > * EH kicks in. =A0Powers up the controller and revalidates all the
>> > =A0 attached devices.
>>
>> At this point the attached devices should still be suspended.
>> Presumably you would not want to revalidate them until their own
>> runtime resumes occur.
>
> Controller resume involves SATA bus resets. =A0As there can be multip=
le
> devices per bus, you can't really divide things that neatly. =A0The
> hardware isn't designed that way.
>
>> > So, it's gonna take a bit more code than posted.
>>
>> On the contrary, there should be almost no new code needed. =A0In fa=
ct,
>> calling pm_runtime_put_noidle() in the probe routine and
>> pm_runtime_get_noresume() in the remove routine should be almost goo=
d
>> enough.
>
> Yeah, that would be nice. =A0I'm quite doubtful that would work as we=
ll
> as you would expect it to tho.
>
> Thanks.
>
> --
> tejun
>
