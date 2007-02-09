From: Tejun Heo <htejun@gmail.com>
Subject: Re: need help with ata error
Date: Fri, 09 Feb 2007 05:37:26 -0500
Message-ID: <45CC4EE6.9010606@gmail.com>
References: <45CC414E.1080609@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:15539 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946354AbXBIKhf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 05:37:35 -0500
Received: by wx-out-0506.google.com with SMTP id h31so779994wxd
        for <linux-ide@vger.kernel.org>; Fri, 09 Feb 2007 02:37:34 -0800 (PST)
In-Reply-To: <45CC414E.1080609@eyal.emu.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-ide <linux-ide@vger.kernel.org>, mikpe@it.uu.se

[cc'ing Mikael Pettersson, hi!]

Eyal Lebedinsky wrote:
> I recently added a 6th disk to a RAID5. All disks are WD 320GB SATA, of different
> Caviar models (SE, RE) and this new one is RE16.
> 
> It worked well for about 5 days (completed a 20 hour grow OK). I now see the following
> messages logged (see at end). Can someone explain what it means? The raid5 is still
> up and it did not react to this. Being a mythtv repository it gets used regularly.
> 
> Is this a disk issue? A controller issue (the new disk is now the fourth on a
> Promise SATA-II-150-TX4)? A kernel problem (2.6.20 vanilla).
> 
> ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata6.00: cmd 25/00:b8:3f:c4:b6/00:00:20:00:00/e0 tag 0 cdb 0x0 data 94208 in
>          res 50/00:00:f6:c4:b6/00:00:00:00:00/e0 Emask 0x1 (device error)

Device error w/o ATA_ERR set?  Mikael, this seems coming from 
PDC_ERR_MASK test in pdc_host_intr().  AC_ERR_DEV means 'the attached 
ATA/ATAPI device indicated error condition', so it isn't really 
appropriate there nor is pdc_reset_port() in IRQ handler.  I guess this 
is from the old EH days.

Unknown errors can use AC_ERR_OTHER which will be automatically cleared 
if error diagnosis results in any real error mask.  I think what should 
be done here is recording irq mask using ata_ehi_push_desc() and setting 
specific AC_ERR_* according to the IRQ mask as ahci and sata_sil24 do.

Eyal, if the error doesn't repeat, you can ignore it.  It probably is a 
transient transmission problem, power fluctuation or whatever.

Thanks.

-- 
tejun
