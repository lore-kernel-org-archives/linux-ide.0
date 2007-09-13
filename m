From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_nv issues with MCP51 SATA controller
Date: Thu, 13 Sep 2007 11:16:02 +0200
Message-ID: <46E8FFD2.5010001@gmail.com>
References: <46E8E440.10601@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:20663 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675AbXIMJRs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Sep 2007 05:17:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so557991wah
        for <linux-ide@vger.kernel.org>; Thu, 13 Sep 2007 02:17:47 -0700 (PDT)
In-Reply-To: <46E8E440.10601@pvv.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Ivar Rykkelid <jonry@pvv.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

Jon Ivar Rykkelid wrote:
> I'm having serious disk-issues when using the on-board nvidia controller
> for my HDDs (My motherboard is a Gigabyte GA-N650SLI-DS4 with nvidia
> chipset, cpu is intel Core2Quad)
> 
> excerpt from "lspci":
> 00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev a1)
> 00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller
> (rev a1)
> 00:0f.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller
> (rev a1)
> 
> I have a normal IDE/P-ATA-disk attached to the "IDE"-controller and that
> works fine (/dev/hda)
> 
> However, any number of disks (I have tried 2 and 4) connected to the
> SATA-controller(s), will eventually fail. - See attached log (excerpt /
> anything relevant from /var/log/messages)
> 
> At first, disks were REALLY unstable, but then I disabled S.M.A.R.T.
> (both in BIOS and Linux), and I updated from the CentOS5 (equivalent of
> RHEL5) kernel (2.6.18) to the latest (at that time) official kernel form
> kernel.org:
> 
>> uname -a
> Linux mirakel 2.6.22.5-custom_jir #2 SMP Thu Aug 30 22:06:21 CEST 2007
> i686 i686 i386 GNU/Linux
> 
> Now it will normally take a day or two before SATA crashes, so things
> are better, but still rather useless.
> 
> First error when sata_nv get into problems is always:
> "exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen"
> (as shown in the attached log-file.) - when this happens to one device,
> it'll almost instantly happen to the other disk attached to that
> controller as well. A couple of minutes (or so) later, the disk(s)
> connected to the other controller will start acting up as well (in the
> same manner). - I/O freezes, and nothing helps except a reboot...
> 
> As I run a rather large (software / md) RAID-5 disk array on this server
> (I'm doing a bit of video editing), every crash means a time-consuming
> rebuild of the disk-array...
> 
> I have given up on the sata_nv / nvidia-controllers for the time being.
> I now resort to some old PCI-connected sata-controllers which work fine
> (but slow, as they are outdated and "overloaded").
> 
> So, if anyone has a good solution / suggestion / improved driver (over
> the one supplied with the official 2.6.22.5-kernel) I am eager to give
> it a go and see if the situation can be resolved.
> 
> I appreciate any sensible suggestions.

Wheeee... the whole controller seems to have went down at once and it's
not even IRQ routing problem - resets are failing.  This is the first
time I see something like this.  Sorry but I don't have any idea what's
going on.  cc'ing Robert.  Any ideas?

-- 
tejun
