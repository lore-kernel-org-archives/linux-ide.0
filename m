From: Felix Miata <mrmazda@earthlink.net>
Subject: Re: sata adapter
Date: Fri, 28 Sep 2012 17:37:33 -0400
Message-ID: <5066189D.3000501@earthlink.net>
References: <201209281704.44471.gheskett@wdtv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:60944 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1032297Ab2I1VqO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2012 17:46:14 -0400
Received: from [69.22.80.46] (helo=[192.168.0.11])
	by elasmtp-dupuy.atl.sa.earthlink.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1THiFa-00009o-Fa
	for linux-ide@vger.kernel.org; Fri, 28 Sep 2012 17:37:34 -0400
In-Reply-To: <201209281704.44471.gheskett@wdtv.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2012-09-28 17:04 (GMT-0400) Gene Heskett composed:

> I have a nearly 30 year old computer that has an aftermarket scsi adapter
> plugged into it.  Unforch the scsi2 drives I have are suffering from
> stiction and will only start if given a tap sufficient to break the seal
> between the disks and the heads.

> So, what I am looking for is a scsi2 (50 pin) adapter so I can use a more
> modern sata drive on it.

If you mean to connect an SATA HD to an old SCSI HBA via an adapter, good 
luck. SATA, PATA and SCSI2 drives are all IDE drives. I doubt any such 
adaptation would be possible.

> Is there such a beast, and if so, where can I buy it in the US?

Exactly what you want to do to make the switch is unclear. If you mean to put 
a SCSI card in a modern PC so that you can copy from the old SCSI HDs to 
modern SATA drives, then you need a SCSI host bus adapter compatible with the 
one in your old computer. If it uses NCR, or Symbios or LSI Logic (e.g. 810, 
815, 825, 875), then 
http://www.ebay.com/itm/Compaq-Symbios-53C875JE-SCSI-Controller-/120260021267?pt=US_Internal_Port_Expansion_Cards&hash=item1c000e4c13 
would be one solution.

If you have an Adaptec SBA in the old machine, then you'd need a similarly 
compatible PCI HBA with an Adaptec chip, such as 
http://www.ebay.com/itm/Adaptec-Ultra-Wide-SCSI-Card-AHA-2940UW-/160870373189?pt=US_Internal_Port_Expansion_Cards&hash=item25749f1745
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

  Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
