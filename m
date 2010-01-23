From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 23 Jan 2010 01:18:24 -0600
Message-ID: <51f3faa71001222318k573d95e6h422b2cd3276e61@mail.gmail.com>
References: <4B591D61.8030003@infernix.net> <4B593128.1040104@gmail.com>
	 <4B59A0CD.4000801@infernix.net> <4B5A4F7A.4040709@gmail.com>
	 <4B5A5F09.1070300@infernix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f186.google.com ([209.85.223.186]:60333 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab0AWHS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jan 2010 02:18:27 -0500
Received: by iwn16 with SMTP id 16so776501iwn.33
        for <linux-ide@vger.kernel.org>; Fri, 22 Jan 2010 23:18:24 -0800 (PST)
In-Reply-To: <4B5A5F09.1070300@infernix.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: infernix <infernix@infernix.net>
Cc: linux-ide@vger.kernel.org

On Fri, Jan 22, 2010 at 8:29 PM, infernix <infernix@infernix.net> wrote=
:
> On 23/01/10 02:23, Robert Hancock wrote:
>>
>> =A0From what I can gather from the ICH7 datasheet, when using AHCI t=
he IDE
>> controller is supposed to show up as device 1f.1 and the SATA contro=
ller
>> as 1f.2. It seems like for some reason your BIOS is disabling the ID=
E
>> controller entirely in that mode, which appears rather wrong.
>
> Well kind of, but not completely since that old IDE PIIX driver does =
work
> when its set to Enhanced AHCI. It's just that it doesn't show up on t=
he PCI
> bus, or so it seems at least.
>
>> Do you have the latest BIOS for that board?
>
> Yes, but it's a SOHO NAS box by Intel; the SS4200-E is the branded on=
e that
> comes with some kind of EMC NAS software, and the ESW is the OEM vers=
ion
> which is sold under various names, without the software. I've got the
> latter.
>
> In either case, there's no BIOS upgrades, only "firmware" which is th=
e EMC
> NAS stuff that gets shipped with the -E version, and Intel put up a n=
otice
> on Jan 10th that the product is discontinued since Dec '09. So that's=
 a dead
> end.
>
> Can we force ata_piix to pick up the IDE controller? I mean the old I=
DE PIIX
> driver can do it (albeit terribly slow), so why can't ata_piix? I won=
't lose
> sleep if I have to pass an option to the kernel or modprobe for this =
to
> happen as it's an uncommon case.

I don't think it actually is the IDE PIIX driver that's picking it up,
it's the generic IDE driver which detects it by banging ports
randomly, and doesn't know anything about DMA support, which is likely
why it's so slow. ata_piix doesn't know about anything that doesn't
show up on the PCI bus.

Since the chipset does have open documentation, one might be able to
develop a PCI quirk that would re-enable the disabled IDE interface so
that ata_piix can access it. That would likely be the best option,
albeit still rather ugly and highly system-specific..
