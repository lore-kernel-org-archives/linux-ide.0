From: Harri Olin <harri.olin@gmail.com>
Subject: Re: sata_mv: trial fix for lost NCQ interrupts
Date: Wed, 14 Jan 2009 23:06:37 +0200
Message-ID: <496E53DD.6040408@gmail.com>
References: <496D04EB.3060803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:39055 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756592AbZANVQf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 16:16:35 -0500
In-Reply-To: <496D04EB.3060803@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Brian Rademacher <rad@radfiles.net>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>

Mark Lord wrote:
> This patch is for trial/critique use only at the moment.
> Once I hear back from a few people who actually use it,
> I'll post an updated fix for upstream/backstream inclusion.
>
> I spent this afternoon nitpicking and bitpicking through the interrupt 
> code
> in sata_mv.c, and I believe I found a race on the hc_irq_cause 
> register.  The
> code was "helpfully" attempting to use read-modify-write to clear 
> individual
> port bits there, but this is impossible to do in a race-free fashion.
>
> So.. the obvious fix is to just write the bits being cleared, without 
> touching
> anything else.  This will also be faster, too, since no read is 
> required or
> desired.  I really don't see a downside, as long as it actually works 
> for everyone.
>
> It does work for me here.

I tried the patch and it works as well as it did without the patch. That 
is to say, timeouts still happen, every couple of minutes on moderate 
read/write load. Patched driver has not seen much use here as the system 
is in production use and it becomes quickly frustrating to wait for 
something to happen.

I also tried removing ATA_PROT_NODATA from libata-sff.c, as mentioned 
earlier, but after that all disks timeout constantly. It also dropped 
all sata_mv connected disks from md array immediately on boot.

I still see timeouts only on 4 lower ports where disk has also been 
connected to port +4. i.e. if port 7 is empty, port 3 will work just 
fine. I just would like to see some confirmation that others are seeing 
this same kind of behavior.

Hardware: Supermicro aoc-sat2-mv8 controller (6081 chip) and WD7500AYYS 
drives.

-- 
Harri.

