From: "Jon Chelton" <jchelton@ffpglobal.com>
Subject: RE: sata_sil24 with port multiplier
Date: Fri, 21 Sep 2007 13:41:06 -0400
Message-ID: <FD6311B7ED175B4480F31633F6098B4D911C4A@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 66-189-16-56.static.oxfr.ma.charter.com ([66.189.16.56]:31468
	"EHLO mail.ffpglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbXIURkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 13:40:03 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Thanks Tejun,  

I have applied the patch and rebuilt the module.  I do not seem to be
getting the same error (although it only shows up during heavy disk
activity).  But now I am getting a lot of spurious interrupts.

ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0xc active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x2 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x8 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x2 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x8 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x4 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x2 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x3 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x9 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x5 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x2 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x6 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0xc active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x1 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0x2 active_tag -84148995 sactive
0x0)
ata5: spurious interrupt (slot_stat 0xa active_tag -84148995 sactive
0x0)


Thanks,

Jon

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Friday, September 21, 2007 3:55 AM
To: Jon Chelton
Cc: linux-ide@vger.kernel.org
Subject: Re: sata_sil24 with port multiplier

Jon Chelton wrote:
> Hello,
> 
>  
> 
> I am having issues using kernel 2.6.22.1 with your latest patch 
> applied.  I am using a Addonics 4 port SATA card with an external 
> enclosure  and port multiplier connected to 4 250GB western digital
SATA
> drives.   I am receiving this error frequently (on 2 systems with
> identical kernels and hardware). 

Does the attached patch fix the problem?

--
tejun

