From: Tejun Heo <tj@kernel.org>
Subject: Re: libata problems
Date: Wed, 14 Jan 2009 14:05:38 +0900
Message-ID: <496D72A2.3050005@kernel.org>
References: <4880BDCD.4030104@gavsworld.net> <4892CDED.6080302@kernel.org> <4898BD4F.90709@gavsworld.net> <4898F11D.1080902@kernel.org> <4899EE03.3060204@gavsworld.net> <48A2AA73.6010901@kernel.org> <495F5AB3.1090800@gavsworld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41974 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbZANFFq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2009 00:05:46 -0500
In-Reply-To: <495F5AB3.1090800@gavsworld.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gavin Cameron <gavin@gavsworld.net>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Gavin Cameron wrote:
> Hello,
> 
> Happy new year first of all :-)
> 
> It's been a while since I've heard anything on this libata problem, so I
> thought I'd see what's happening.
> 
> I have some good news though: one of my PCs is working fine now - kirk
> (which I've recently switched from Fedora to Ubuntu)
> 
>     * Gigabyte GA-7DX M/B (AMD 761 / VIA 686B chipset)
>     * AMD Althlon XP 2100+
>     * PATA LiteOn DVD-RW
>     * Ubuntu 8.10 - kernel 2.6.27-9-generic
> 
> However, picard is still not working:
>     * ASUS M2V M/B (VIA K8T890 / VIA VT8237A chipset)
>     * AMD Athlon 64 X2 6000+
>     * PATA LiteOn DVD RAM/RW
>     * Fedora 10 - kernel 2.6.27.9-159.fc10.x86_64
> 
> I'm currently booting with this from grub:
> title Fedora (2.6.27.9-159.fc10.x86_64)
>     root (hd0,2)
>     kernel /vmlinuz-2.6.27.9-159.fc10.x86_64 ro
> root=UUID=5d9cfdad-6c2f-4f95-840f-99080642519c rhgb quiet pci=noacpi
>     initrd /initrd-2.6.27.9-159.fc10.x86_64.img
> 
> Which is the standard Fedora option (plus the noacpi).
> 
> I've attached some log files to assist in further debug.
> 
> The /var/log/messages file is very long (so appologies for this), but I
> noticed something interesting: on 2nd of Jan, there were no CDs inserted
> into the drive at all that day, yet there is trouble communicating with
> the drive. Today is the 3rd and the ata messages at the end are when I
> inserted a CD.
> 
> The problem with picard is that it refuses to read CDs/DVDs placed in
> the PATA drive (unless it has been within a few minutes of powering up)
> and also that the PATA hard drive still performs frequent head unloads.
> 
> If you require any other information, please let me know.

Does irqpoll help?

-- 
tejun
