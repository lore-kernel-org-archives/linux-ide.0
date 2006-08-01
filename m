From: Roger Oberholtzer <roger@opq.se>
Subject: Re: libata question
Date: Tue, 01 Aug 2006 21:03:01 +0200
Message-ID: <1154458981.4665.9.camel@shark.pacific>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>
	 <1154457583.4665.5.camel@shark.pacific>  <44CFA15C.8080109@gmail.com>
Reply-To: roger@opq.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.surbrunn.net ([195.84.183.170]:37125 "EHLO
	Tule.surbrunn.net") by vger.kernel.org with ESMTP id S1751793AbWHAS56
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 14:57:58 -0400
In-Reply-To: <44CFA15C.8080109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 2006-08-02 at 03:45 +0900, Tejun Heo wrote:
> Roger Oberholtzer wrote:
> > On Wed, 2006-08-02 at 00:33 +0900, Tejun Heo wrote:
> >> Roger Oberholtzer wrote:
> >>> Should hotplug work with Intel Corporation 82801GB/GR/GH (ICH7
> >>> Family) chipset? I am trying kernel 2.6.17.7
> 
> Ah.. I should have spotted this earlier.  2.6.17.7 doesn't contain 
> updated EH and doesn't support any of new features including 
> hot/warmplug.  Please try 2.6.18-rc3.

OK. But I think there are issues with 2.6.18 generally. But I can try it
to see if this makes this better.

> 
> >>> I have been trying the warmplug stuff. But I am not convinced it is 
> >>> acting as I expect. If I remove a disk and then do a scan, shouldn't
> >>> the disk entry go away?
> >> Eventually, yes.  Do you mind to send me the dmesg?
> > 
> > I have picked out the lines related to this. Some of the complaints at
> > the end are probably when I moved the disk. 
> 
> Yeap, those look pretty normal for the previous code.  :p
> 
> >>> I know about the problems with just removing a disk. But this is with
> >>> one that is not mounted. I just want to see if the disks are properly
> >>> sensed as coming and going. I am using the warmplug instructions on
> >>> your web site.
> >> There are some complications with piix PCS register (port 
> >> enable/disable) which always seems to have some problem.  If you can use 
> >> AHCI mode, it will be *much* better.
> > 
> > OK. How do I get it in ahci mode? I see that both the ata_piix and achi
> > drivers are loaded. This is what is loaded:
> 
> Plain ICH7 doesn't support ahci. ICH7R supports ahci mode and usually 
> configurable in the BIOS menu.  On my board (P5LD2), it's in the first 
> page (the left-most one where the clock setting is and hard disks are 
> enumerated), it's called IDE configuration or something.

I will look. I have a SuperMicro motherboard.

> >> If you think the driver doesn't do the right thing(tm), please send me 
> >> detailed info.  I'll try to fix the problem if possible or explain why 
> >> it can't be fixed at the very least.
> > 
> > I bet the driver does the right thing. The trick is knowing what that is
> > supposed to be. And how to use the various commands on files in /sys at
> > the correct time and in the correct order.
> 
> Really, it's not that complicated.

Once you know what it is you need to do.

--
Roger Oberholtzer

