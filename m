From: "Aneurin Price" <aneurin.price@gmail.com>
Subject: Re: Promise SATA 300 TX2plus: disk stops responding
Date: Fri, 4 Jul 2008 19:50:17 +0100
Message-ID: <501db8660807041150r5f800839m4815275d6542760@mail.gmail.com>
References: <200807021136.m62BaPvx026056@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:54874 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbYGDSuT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jul 2008 14:50:19 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1283571wfd.4
        for <linux-ide@vger.kernel.org>; Fri, 04 Jul 2008 11:50:18 -0700 (PDT)
In-Reply-To: <200807021136.m62BaPvx026056@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

On Wed, Jul 2, 2008 at 12:36 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> On Sun, 29 Jun 2008 17:14:12 +0100, Aneurin Price wrote:
>>I have a 500GB Seagate disk[0] attached to an el-cheapo PCI-plugin
>>Promise SATA controller[1], which I've had for a couple of years. Every
>>so often, the disk stops responding and is eventually disabled. I'm
>>trying to determine whether this is a hardware fault or not - and if so,
>>whether the disk or the controller is at fault; any insight would be
>>appreciated.
> ...
>>The controller card was previously in use in another system without
>>issue, with a 300GB disk which is otherwise similar (the current disk is
>>essentially the upgraded model). That system was less frequently left
>>running for the length of time that the problematic machine is though.
>
> Same controller but different disks and machines. That's a sign
> of a hardware issue with either the disk or the machine.
>

Well there is a possibility that the card was never in continuous use long
enough for the problem to manifest itself, but I couldn't say what the
likelihood of that is.

>>At first I tried making sure that it was adequately cooled, the cables
>>were all firmly in, etc. I also set the jumper on the disk to limit it
>>to 1.5gbps, having read about a couple of potential problems with 3gbps
>>access using some controllers supported by sata_promise [2]. I've even
>>moved the disk and the controller card into a new machine, to eliminate
>>any other possible causes, so the problem must be either with the disk,
>>the controller, some interaction between them, or a software issue.
>
> Inadequate power supplies are also common sources of problems.
> And in another problem report the source turned out to be lack
> of grounding between the disk and the chassis.
>

The power supply did occur to me, however this machine previously contained a
fairly beefy NVidia graphics card (one of the most powerful AGP cards); that was
removed and replaced with the bigger disk when it was re-purposed as a file
server. I'm presuming that the graphics card would have had higher power
requirements than the disk (it certainly got damn hot in heavy use). If that's
not necessarily the case, do let me know.

The grounding idea is interesting and had never occurred to me. The disk is
screwed into the chassis so I'd imagine that would be okay, but it can't hurt to
double-check; thanks for the tip.

>>[0] I believe it is a Barracuda ST3500630AS, but as it's currently
>>inaccessible I can't be sure until I reboot.
>>
>>[1] lspci says:
>>00:09.0 Mass storage controller: Promise Technology, Inc. PDC40775
>>(SATA 300 TX2plus) (rev 02)
> ...
>>[    0.000000] Linux version 2.6.24-18-server (buildd@terranova) (gcc
>>version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #1 SMP Wed May 28 21:25:52 UTC
>>2008 (Ubuntu 2.6.24-18.32-server)
>
> 2.6.24 plus unknown patches.
>
>>[   20.525637] Enabling SiS 96x SMBus.
>
> A SiS chipset box.
>
...
>
> Two disks, a big SATA one on the TX2plus and a small PATA one on the SiS
> controller.
>
>>[1382260.429883] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
>>0x2 frozen
>>[1382260.429931] ata1.00: cmd 25/00:50:27:6e:cd/00:00:15:00:00/e0 tag
>>0 dma 40960 in
>>[1382260.429933]          res 40/00:00:00:00:00/00:00:00:00:00/00
>>Emask 0x4 (timeout)
>>[1382260.429956] ata1.00: status: { DRDY }
>>[1382265.796276] ata1: port is slow to respond, please be patient (Status
>>0xff)
>>[1382270.473163] ata1: device not ready (errno=-16), forcing hardreset
>>[1382270.473179] ata1: hard resetting link
>>[1382276.679024] ata1: port is slow to respond, please be patient (Status
>>0xff)
>>[1382280.476592] ata1: COMRESET failed (errno=-16)
>>[1382280.476626] ata1: hard resetting link
>>[1382286.692400] ata1: port is slow to respond, please be patient (Status
>>0xff)
>>[1382290.529795] ata1: COMRESET failed (errno=-16)
>>[1382290.529829] ata1: hard resetting link
>>[1382296.745702] ata1: port is slow to respond, please be patient (Status
>>0xff)
>>[1382325.566448] ata1: COMRESET failed (errno=-16)
>>[1382325.566484] ata1: limiting SATA link speed to 1.5 Gbps
>>[1382325.566487] ata1: hard resetting link
>>[1382330.573112] ata1: COMRESET failed (errno=-16)
>>[1382330.573146] ata1: reset failed, giving up
>>[1382330.573162] ata1.00: disabled
>>[1382330.573188] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002
>>action 0xa frozen t4
>>[1382330.573212] ata1: hotplug_status 0x10
>>[1382330.573226] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
> ...
>>[1382571.052939] ata1: EH pending after 5 tries, giving up
>
> These are signs of the disk going offline, or the communication between
> the controller and the disk being corrupted. That's a hardware issue,
> not unlike what we see with bad PSUs.
>
> The 2.6.24 kernel lacks two post-2.6.24 sata_promise bug fixes.
> The first fixes a problem where error recovery may trigger unexpected
> hotplug events (we see those in your log), the second fixes a potential
> problem in interrupt status clearing operations.
>

Does this mean that it could potentially be possible to recover from this error,
even without nailing the cause? Are random hardware problems of this sort quite
common, and papered over by good drivers as a matter of course?

> These fixes are in the 2.6.26-rc8 kernel. For 2.6.24 you can apply
> the following two patches:
> <http://user.it.uu.se/~mikpe/linux/patches/sata_promise/2.6.24/patch-sata_promise-1-fix-hardreset-hotplug-events-2.6.24>
> <http://user.it.uu.se/~mikpe/linux/patches/sata_promise/2.6.24/patch-sata_promise-2-irqclear-2.6.24>

Thanks for the information. I'll probably wait until 2.6.26 is released (as it
seems to be imminent) and see if that changes anything.

>
> (And please make sure you're not running smartd while testing
> changes/patches/etc.)
>

I've not run smartd at all so far, but I'll bear that in mind!

> /Mikael
>

Thank you for your help,

Nye
