From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: sda
Date: Sun, 13 Apr 2008 04:17:12 +0000
Message-ID: <dd18b0c30804122117hc0cd548v6cbef5d2c0c0ce5e@mail.gmail.com>
References: <dd18b0c30804021244k1d44a48hc05ea88552104a71@mail.gmail.com>
	 <48016F54.5070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:52916 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750700AbYDMERN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Apr 2008 00:17:13 -0400
Received: by an-out-0708.google.com with SMTP id d31so276676and.103
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 21:17:12 -0700 (PDT)
In-Reply-To: <48016F54.5070405@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Apr 13, 2008 at 2:26 AM, Tejun Heo <htejun@gmail.com> wrote:
> Justin Mattock wrote:
>
> > Hello; hopefully this is the correct e-mail for libata.  I compiled
> > 2.6.25-rc8 on a macbook pro 15' ati chipset using nubuntu. when
> > performing
> > echo mem > /sys/power/state simultaneously I'm noticing on the third time:
> >
> > [ 2332.951249] sd 2:0:1:0: [sda] Starting disk
> > [ 2313.224530] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
> > [ 2313.224532] ata1.00: ACPI cmd ef/03:44:00:00:00:a0 filtered out
> > [ 2313.391129] ata1.00: configured for UDMA/66
> > [ 2314.187258] ata3.01: NODEV after polling detection
> > [ 2314.187262] ata3.01: revalidation failed (errno=-2)
> > [ 2314.187266] ata3: failed to recover some devices, retrying in 5 secs
> > [ 2319.368648] ata3.01: ACPI cmd ef/03:0c:00:00:00:b0 filtered out
> > [ 2319.368654] ata3.01: ACPI cmd ef/03:45:00:00:00:b0 filtered out
> > [ 2319.382275] ata3.01: configured for UDMA/100
> > [ 2319.400505] sd 2:0:1:0: [sda] 234441648 512-byte hardware sectors
> (120034 MB)
> > [ 2319.400505] sd 2:0:1:0: [sda] Write Protect is off
> > [ 2319.400505] sd 2:0:1:0: [sda] Mode Sense: 00 3a 00 00
> > [ 2319.400505] sd 2:0:1:0: [sda] Write cache: enabled, read cache:
> > enabled, doesn't support DPO or FUA
> >
> > revalidation error=-2
> > attached is dmesg from the test
> >
>
>  Can you please post the result of "lspci -nn".  The error per-se is okay.
> The drive failed to respond to IDENTIFY at the first try but on retrial it
> responded okay.
>
>  --
>  tejun
>

Hello; Thank you for the response.
I guess you can say I have a tendancy to freak out or panic with
little things like that,
below is lspci -nn.




00:00.0 Host bridge [0600]: Intel Corporation Mobile 945GM/PM/GMS,
943/940GML and 945GT Express Memory Controller Hub [8086:27a0] (rev
03)
00:01.0 PCI bridge [0604]: Intel Corporation Mobile 945GM/PM/GMS,
943/940GML and 945GT Express PCI Express Root Port [8086:27a1] (rev
03)
00:07.0 Performance counters [1101]: Intel Corporation Unknown device
[8086:27a3] (rev 03)
00:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family)
High Definition Audio Controller [8086:27d8] (rev 02)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 1 [8086:27d0] (rev 02)
00:1c.1 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 2 [8086:27d2] (rev 02)
00:1c.2 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 3 [8086:27d4] (rev 02)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #1 [8086:27c8] (rev 02)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #2 [8086:27c9] (rev 02)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #3 [8086:27ca] (rev 02)
00:1d.3 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #4 [8086:27cb] (rev 02)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB2 EHCI Controller [8086:27cc] (rev 02)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
[8086:2448] (rev e2)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801GBM (ICH7-M) LPC
Interface Bridge [8086:27b9] (rev 02)
00:1f.1 IDE interface [0101]: Intel Corporation 82801G (ICH7 Family)
IDE Controller [8086:27df] (rev 02)
00:1f.2 IDE interface [0101]: Intel Corporation 82801GBM/GHM (ICH7
Family) SATA IDE Controller [8086:27c4] (rev 02)
00:1f.3 SMBus [0c05]: Intel Corporation 82801G (ICH7 Family) SMBus
Controller [8086:27da] (rev 02)
01:00.0 VGA compatible controller [0300]: ATI Technologies Inc M56P
[Radeon Mobility X1600] [1002:71c5]
02:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd.
88E8053 PCI-E Gigabit Ethernet Controller [11ab:4362] (rev 22)
03:00.0 Network controller [0280]: Atheros Communications, Inc. AR5418
802.11abgn Wireless PCI Express Adapter [168c:0024] (rev 01)
0c:03.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB82AA2
IEEE-1394b Link Layer Controller [104c:8025] (rev 01)


Besides the SATA drive, with the PATA ATAPI drive, I'm running a
little test of playing a DVD, then performing a suspend, upon wakeup
The movie becomes choppy;
"Basically what I can see over here is"; when the system is wokenup
whatever is left in the ram or memory continues to play, In the meantime
the PATA drive from what I can hear, moves around a little bit thinks
for a second, then starts turning fast, but by then whatever was in
the ram or memory has played, causing the playback to be out of sync,
resulting in a choppy feed.
Idealistically I would like to take the media player, and have it wait
for the DVD to catch up then start playback, Or see If when suspend
occurs (if possible)the lens in the PATA keeps the position, then upon
resume PATA resumes, Or If this is already available try and enable
that feature.

-- 
Justin P. Mattock
