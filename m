From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Red leds at harddisk bays on SR1530HSH after update to 2.6.27.x
Date: Fri, 19 Dec 2008 22:32:46 -0800
Message-ID: <20081219223246.b0aea84d.akpm@linux-foundation.org>
References: <494A34CA.9030906@bigtelecom.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33392 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157AbYLTGcy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Dec 2008 01:32:54 -0500
In-Reply-To: <494A34CA.9030906@bigtelecom.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Badalian Vyacheslav <slavon@bigtelecom.ru>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

(cc linux-ide)

On Thu, 18 Dec 2008 14:32:26 +0300 Badalian Vyacheslav <slavon@bigtelecom.ru> wrote:

> Hello all.
> After update from 2.6.26 to 2.6.27 all leds at drive bays now red.
> SATA controller in AHCI mode.
> Platform is Intel SR1530HSH
> 
> Config attached.
> 
> Any patches for test? Any ideas? Any other info needed? Or i must go to
> bugtracker? ;)
> 
> # lspci
> 00:00.0 Host bridge: Intel Corporation 3200/3210 Chipset DRAM Controller
> 00:19.0 Ethernet controller: Intel Corporation 82566DM-2 Gigabit Network
> Connection (rev 02)
> 00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
> Controller #4 (rev 02)
> 00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
> Controller #5 (rev 02)
> 00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI
> Controller #2 (rev 02)
> 00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express
> Port 1 (rev 02)
> 00:1c.4 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express
> Port 5 (rev 02)
> 00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
> Controller #1 (rev 02)
> 00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
> Controller #2 (rev 02)
> 00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
> Controller #3 (rev 02)
> 00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI
> Controller #1 (rev 02)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92)
> 00:1f.0 ISA bridge: Intel Corporation 82801IR (ICH9R) LPC Interface
> Controller (rev 02)
> 00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6
> port SATA AHCI Controller (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller
> (rev 02)
> 02:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200e
> [Pilot] ServerEngines (SEP1) (rev 02)
> 03:02.0 Ethernet controller: Intel Corporation 82541GI Gigabit Ethernet
> Controller (rev 05)
> 
> Thanks!
> 
