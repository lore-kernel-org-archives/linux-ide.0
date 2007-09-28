From: "Jon Chelton" <jchelton@ffpglobal.com>
Subject: RE: sata_sil24 with port multiplier
Date: Fri, 28 Sep 2007 12:08:43 -0400
Message-ID: <FD6311B7ED175B4480F31633F6098B4D911D11@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 66-189-16-56.static.oxfr.ma.charter.com ([66.189.16.56]:44823
	"EHLO mail.ffpglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbXI1QHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 12:07:35 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This error occurred when assembling a software raid 5 array using mdadm.
It also happened when copying large amounts of data from one drive to
another.  I saw from an earlier post to disable or upgrade smartd.  I
tried this (disabled) and moved about 50gb between disks and the error
has not repeated yet.

Jon

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Friday, September 28, 2007 3:24 AM
To: Jon Chelton
Cc: linux-ide@vger.kernel.org
Subject: Re: sata_sil24 with port multiplier

Jon Chelton wrote:
> After applying the patches you sent, I had not received any additional
> errors until today.  Below is an output from dmesg.
> 
> ata1.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata1.15: irq_stat 0x00020002, PMP DMA CS errata
> ata1.00: exception Emask 0x100 SAct 0x18084200 SErr 0x0 action 0x6
> frozen
> ata1.00: cmd 60/00:48:3f:8f:fa/01:00:0a:00:00/40 tag 9 cdb 0x0 data
> 131072 in
>          res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
> error)

Hmmm... So, when did the above error occur?  Can you reproduce it?

-- 
tejun

