From: Mark Hatle <fray@gate.crashing.org>
Subject: Re: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Tue, 24 Oct 2006 23:35:11 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0610242329160.22827@gate.crashing.org>
References: <Pine.LNX.4.64.0610242257410.21847@gate.crashing.org>
 <20061025042811.GJ13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:19870 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422952AbWJYEfO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Oct 2006 00:35:14 -0400
In-Reply-To: <20061025042811.GJ13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org

(response inline)

On Wed, 25 Oct 2006, Tejun Heo wrote:

> Hello,
>
> On Tue, Oct 24, 2006 at 11:01:11PM -0500, Mark Hatle wrote:
> [--snip--]
>> When the sata_nv error occurs, raid takes the drive offline, and the
>> system requires a hard power cycle to reactive the drive.
>>
>> This has occured 5 times since Saturday.  The first time the system
>> was up more then 12 hours.. second time about the same.. 3rd, 4th
>> and 5th times occured within 2 hours of the system starting.
>>
>> If there is any other information you need let me know!
>
> Does the problem occur on 2.6.18 but not on earlier version?  If it
> doesn't happen on 2.6.17, we can rule out h/w problem.

This is a brand new machine.. I did a bunch of hammering on SATA before it 
went into production, but of course it didn't start to fail until now. 
I'm not sure if there is an easy way for me to switch to 2.6.17.

>> IDE/Raid failure information:
>>
>> Oct 24 16:15:59 gate kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0
>> action 0x2 frozen
>> Oct 24 16:15:59 gate kernel: ata1.00: (BMDMA stat 0x24)
>> Oct 24 16:15:59 gate kernel: ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40
>> err 0x0 (timeout)
>
> The BMDMA register is reporting transaction complete and the stat
> register is indicating drive ready.  This looks like a lost interrupt
> to me.  Any interesting messages before this error log?

Nothing.. unusual before then.

/proc/interrupts:
            CPU0       CPU1
   0:    8249589          0          XT-PIC  timer
   1:        180        253    IO-APIC-edge  i8042
   8:          0          0    IO-APIC-edge  rtc
   9:          0          0   IO-APIC-level  acpi
  14:     164445     130620    IO-APIC-edge  ide0
  50:     494503     489812   IO-APIC-level  libata
  58:     214789     677599   IO-APIC-level  libata
  66:         60          0   IO-APIC-level  sym53c8xx
  74:    3846094          0   IO-APIC-level  eth0
225:         68         25   IO-APIC-level  ohci_hcd:usb1
233:          2          0   IO-APIC-level  ehci_hcd:usb2

IRQ 50 is the sata_nv.  It's currently halted and not doing anything.

>> Oct 24 16:16:00 gate kernel: ata1: soft resetting port
>> ...
>> Oct 24 16:16:30 gate kernel: ata1: failed to recover some devices, retrying
>> in 5 secs
>
> The first retry also failed due to IDENTIFY timeout although the drive
> and controller responded to SRST properly.  If this problem is caused
> by IRQ delivery failure, this behavior is expected.

Could it be an SMP issue?  I could restart and turn off SMP and give it a 
try.

> [--snip--]
>
> The normal command execution path didn't change in any significant way
> between 2.6.17 and .18.
>
> * If 2.6.17 shows the same problem : could be a faulty drive or
>  problem in the controller.  NV SATA controllers supply two
>  interfaces - legacy TF/BMDMA and ADMA.  The former tends to react
>  badly when error condition occurs.  Driver for ADMA interface is
>  under development.  It could be that the controller cannot cope with
>  transient transmission errors.  If this is the case, ADMA driver
>  should be able to fix it.
>
> * If 2.6.17 doesn't show the same problem : My first suspicion is
>  weird IRQ problem.  Play with the usual IRQ options - acpi, noacpi,
>  etc... and see if anything changes.

I'll see if I can get a 2.6.17 kernel booted on this machine... (I'm used 
to embedded systems, not all of the complication of Fedora booting.. so it 
might take me a bit to figure out how to actually get it to boot)  :)

Thank you for your help,
Mark
