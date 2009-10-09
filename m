From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil24 blows up under load, please help diagnose
Date: Thu, 08 Oct 2009 19:21:39 -0600
Message-ID: <4ACE9023.8080301@gmail.com>
References: <bb145bd20910081136m1b4e23e2nfeae068f693c3f64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:55188 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbZJIBWS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Oct 2009 21:22:18 -0400
Received: by qyk2 with SMTP id 2so6151971qyk.21
        for <linux-ide@vger.kernel.org>; Thu, 08 Oct 2009 18:21:42 -0700 (PDT)
In-Reply-To: <bb145bd20910081136m1b4e23e2nfeae068f693c3f64@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Pernegger <pernegger@gmail.com>
Cc: linux-ide@vger.kernel.org

On 10/08/2009 12:36 PM, Christian Pernegger wrote:
> Hi all!
>
> My new box doesn't seem to like its sata_sil24 controllers under load.
>
> The attached log snippet (syslog.gz) is of the first occurrence of the
> error, some tens of minutes into a checkarray --all (basically does
> echo check>/sys/block/md*/md/sync_action). End result was a hang
> where not even Alt-SysRq would do any good. It isn't md, though, just
> running badblocks on all disks on one of the sata_sil24s in parallel
> does the trick as well.
>
> The error messages are not always exactly the same and do not always
> result in a hang of the whole machine. More recently I've had:
> [  632.710900] sata_sil24: IRQ status == 0xffffffff, PCI fault or
> device removal?
> [  632.820017] ata13.00: exception Emask 0x20 SAct 0xffff SErr 0x0
> action 0x6 frozen
> [  632.820073] ata11.00: exception Emask 0x20 SAct 0xbfff SErr 0x0
> action 0x6 frozen
> [  632.820076] ata11.00: irq_stat 0x00020002, PCI master abort while
> transferring data

Looks like there's something unhappy between the card and the motherboard..

> [  632.820083] ata11.00: cmd 60/00:00:3f:62:45/04:00:00:00:00/40 tag 0
> ncq 524288 in
> [  632.820085]          res 6c/0b:02:02:00:00/00:00:00:00:6c/00 Emask
> 0x22 (host bus error)
> [  632.820087] ata11.00: status: { DRDY DF DRQ }
> [  632.820093] ata11.00: cmd 60/00:08:3f:46:45/04:00:00:00:00/40 tag 1
> ncq 524288 in
> [  632.820094]          res 6c/0b:02:02:00:00/00:00:00:10:6c/00 Emask
> 0x22 (host bus error)
> [  632.820096] ata11.00: status: { DRDY DF DRQ }
> ... and so on for the other in-flight tags ...
>
> Hard- and Software:
> Tyan Toledo iE3210W (S5211), 6x SATA-300 [ahci]
> Intel C2Q 9550s
> 8GB Crucial DDR2-ECC RAM
> 2x Dawicontrol DC-4320 RAID in the PCI-X 133 slots, 4x SATA-300
> [sata_sil24] each, RAID BIOS' disabled via jumper

Please see the recent post from Bernie Innocenti "sata_mv 0000:03:06.0: 
PCI ERROR; PCI IRQ cause=0x30000040". I suspect you could have a similar 
problem with the system running at too high a PCI-X bus clock speed with 
two cards installed.

> 3x RaidSonic IB-554SSK "backplane" (datasheet:
> http://www.raidsonic.de/de/data/data_pdf/icybox/datasheet_ib-555_554_553_d.pdf)
> Debian stable (lenny)
>
> backplane 1 (onboard ahci controller):
> - 2x WD5000YS in raid1 = sd[ab][12]
> - 2x WD10EADS in raid1 = sd[cd]1
> These work flawlessly.
>
> backplane 2 (sata_sil24 on PCI-X 133):
> - 4x WD1000FYPS = sd[efgh]1
>
> backplane 3 (sata_sil24 on PCI-X 133):
> - 3x WD1002FBYS = sd[ijk]
> - 1x empty tray
>
> Tried temorarily powering half the disks via a second power supply,
> tried exchanging the power supply, tried switching around cables to
> maybe isolate a culprit backplane or controller. That last one
> actually looked promising for a while, but testing wasn't conclusive.
> Tried a bunch of dirrerent kernels: 2.6.26-19 (lenny) and 2.6.30-7
> (lenny-backports), 2.6.32-rc3 (vanilla). Not much difference.
>
> Unfortunately just scrapping the box isn't an option as this is a
> personal project and the budget's just too tight ATM. Any pointers on
> what I could try to narrow down which component is faling or what's
> going on in general?
>
> Also see the attached dmesg, although that's NOT from the same boot as
> the syslog snippet.
>
> Thank you,
>
> Christian

