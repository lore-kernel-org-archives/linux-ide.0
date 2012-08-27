From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Mon, 27 Aug 2012 09:50:55 +0200
Message-ID: <201208270950.55590.rjw@sisk.pl>
References: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com> <20120825113301.GA15210@liondog.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:34319 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab2H0Ho4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Aug 2012 03:44:56 -0400
In-Reply-To: <20120825113301.GA15210@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Adko Branil <adkobranil@yahoo.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Saturday, August 25, 2012, Borislav Petkov wrote:
> On Fri, Aug 24, 2012 at 06:31:11PM -0700, Adko Branil wrote:
> > To add some more info - i just noticed in dmesg of the latest kernel-2.5.2 some suspicious lines:
> > 
> > 	* [   44.251706] microcode: AMD CPU family 0xf not supported
> > 	* [   44.255721] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ (2 cpu cores) (version 2.20.00)
> > 	* [   44.255736] [Firmware Bug]: powernow-k8: No compatible ACPI _PSS objects found.
> > 	* [   44.255736] [Firmware Bug]: powernow-k8: Try again with latest BIOS.
> > 
> > Coult it be related to the crashes , and should i update my bios ?
> 
> No.
> 
> Try to enable the Cool'n'Quiet option in your BIOS - this message should
> disappear then.
> 
> Btw, there's a patch to make this more understandable:
> 
> http://marc.info/?l=linux-kernel&m=134262430326493
> 
> Rafael, this one is queued for 3.7, I assume?

Well, it should be, but I seem to have failed to merge my pm-cpufreq-next branch
into linux-next.  Sorry about that, will fix when I get back home from the
KS/LinuxCon.

Thanks,
Rafael
