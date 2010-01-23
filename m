From: infernix <infernix@infernix.net>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 23 Jan 2010 03:29:29 +0100
Message-ID: <4B5A5F09.1070300@infernix.net>
References: <4B591D61.8030003@infernix.net> <4B593128.1040104@gmail.com> <4B59A0CD.4000801@infernix.net> <4B5A4F7A.4040709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dx.infernix.net ([83.96.151.193]:49030 "EHLO dx.infernix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614Ab0AWC3b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jan 2010 21:29:31 -0500
In-Reply-To: <4B5A4F7A.4040709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On 23/01/10 02:23, Robert Hancock wrote:
>  From what I can gather from the ICH7 datasheet, when using AHCI the IDE
> controller is supposed to show up as device 1f.1 and the SATA controller
> as 1f.2. It seems like for some reason your BIOS is disabling the IDE
> controller entirely in that mode, which appears rather wrong.

Well kind of, but not completely since that old IDE PIIX driver does 
work when its set to Enhanced AHCI. It's just that it doesn't show up on 
the PCI bus, or so it seems at least.

> Do you have the latest BIOS for that board?

Yes, but it's a SOHO NAS box by Intel; the SS4200-E is the branded one 
that comes with some kind of EMC NAS software, and the ESW is the OEM 
version which is sold under various names, without the software. I've 
got the latter.

In either case, there's no BIOS upgrades, only "firmware" which is the 
EMC NAS stuff that gets shipped with the -E version, and Intel put up a 
notice on Jan 10th that the product is discontinued since Dec '09. So 
that's a dead end.

Can we force ata_piix to pick up the IDE controller? I mean the old IDE 
PIIX driver can do it (albeit terribly slow), so why can't ata_piix? I 
won't lose sleep if I have to pass an option to the kernel or modprobe 
for this to happen as it's an uncommon case.
