From: Tejun Heo <tj@kernel.org>
Subject: Re: Intel AHCI ICH9R not detecting devices
Date: Sat, 30 Aug 2008 12:40:25 +0200
Message-ID: <48B92399.6010808@kernel.org>
References: <WorldClient-F200808221729.AA29360172@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59337 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbYH3Kmb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 06:42:31 -0400
In-Reply-To: <WorldClient-F200808221729.AA29360172@butn.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: xerces8 <xerces8@butn.net>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, stein@hermes.si

Hello,

xerces8 wrote:
> I noticed that recent kernels do not detect my SATA devices (two
> SATA hard drives and one DVD unit).
> 
> HW: Asus P5K-E WiFi mainboard, BIOS version 1013 (latest as of now)
> BIOS setup: SATA adapter mode : AHCI
> CPU: Intel Core2 Q6600 (not overclocked)
> RAM: 4x2GB DDR2-800
> 
> Kernel: 2.6.26.3 (vanilla unpatched)
> arch: i386
> 
> kernel config : http://pastebin.com/f7640ead2
> dmesg output : http://pastebin.com/f3b3fac14
> lspci: http://pastebin.com/f2a3edebf
> lspci -v -n : http://pastebin.com/f724cf3
> /proc/cpuinfo: http://pastebin.com/f11930c44

It's usually best to include relevant excerpts inline and then attach
the whole stuff as attachments.  Posting links to some URL or non-OSDL
bugzilla entries is likely to significantly increase your chance of
just being skipped over.  You know, we're cranky nerds who hate the
web and stick to 80-column terminals.  ;-)

 ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
 ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part
 PCI: Setting latency timer of device 0000:00:1f.2 to 64
 ACPI: PCI interrupt for device 0000:00:1f.2 disabled
 ahci: probe of 0000:00:1f.2 failed with error -16

This looks like resource conflict to me, which could have resulted
from ahci trying to grab all resources.  Can you please post the
result of "cat /proc/ioports" and "cat /proc/iomem"?

> Funny thing, in 64 bit mode it all works fine (tested and first
> discovered with RIPLinux 6.3; the above config should match the 32 bit
> config from riplinux)

Yeah, different arch codes can do strange things to PCI IRQ routing or
resource allocations.

-- 
tejun
