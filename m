From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Kernel Bug in ATA or SMART area
Date: Thu, 18 Feb 2010 11:50:06 +0100
Message-ID: <19325.7006.892019.748974@pilspetsen.it.uu.se>
References: <4B72941A.7060704@gmx.de>
	<4B74BDCF.1010805@kernel.org>
	<4B74F263.1060709@gmx.de>
	<4B7505CA.60409@kernel.org>
	<4B75154B.8030507@gmx.de>
	<4B7B548B.4040606@kernel.org>
	<4B7C5696.7030609@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:32914 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756721Ab0BRKuN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Feb 2010 05:50:13 -0500
In-Reply-To: <4B7C5696.7030609@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Axel Uhl <axel.uhl@gmx.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Axel Uhl writes:
 > Here's what /var/log/dmesg contains:
...
 > Tejun Heo wrote:
 > > Hello,
 > > 
 > > On 02/12/2010 05:46 PM, Axel Uhl wrote:
 > >> I don't have a /var/log/boot.msg, only a /var/log/boot. Its contents:
 > > 
 > > Then please attach output of dmesg after boot.

Judging from your initial message and this one, it appears that the
problematic disk is driven by sata_via, but sata_via shares IRQ with
an awful lot of other junk.

Suggestions:
1. Enable IO/APIC support in the kernel. According to your previous lspci
   the chipset does have one. This should reduce IRQ sharing and make IRQ
   handling generally better. If there's still some sharing going on,
   try moving PCI cards to other slots.
2. Move the problematic disk around to e.g. the Promise controller. Do the
   stray exceptions persist? If so, then it's the disk that's at fault.
   As long as the libata's error handling recovers, things should work anyway.
3. (Unrelated but...) Why use Old IDE to drive the VIA PATA controller?
   Just use pata_via for that one, enable SCSI SR+SG support, and disable IDE.
