From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: ATA_PIIX - soft resetting port, port is slow to respond, machine
 "freezes" for a few seconds
Date: Sat, 01 Sep 2007 22:49:25 +0200
Message-ID: <46D9D055.9070901@wpkg.org>
References: <46D94BBB.9080403@wpkg.org>	 <6b9952490709010500q2a93156cq399434a3a44a2d25@mail.gmail.com>	 <46D95A6F.6060808@wpkg.org> <6b9952490709010707i33e49d19o2fa44f5bec4e367d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:46990 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392AbXIAUtf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 16:49:35 -0400
In-Reply-To: <6b9952490709010707i33e49d19o2fa44f5bec4e367d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joris <joris@v5.be>, Linux IDE <linux-ide@vger.kernel.org>

Joris schrieb:
> Hello,
> 
> 
> Would this be an intel motherboard?
> I'm running on an intel 3000AHLX, also with an adaptec scsi controller, hmm...

dmidecode says it's Intel:

         Vendor: Intel Corporation
         Version: SE7320SP20.86B.P.09.00.0039.092120051351
         Release Date: 09/21/2005

System Information
         Manufacturer: Acer
         Product Name: Altos G520 Altos G520

Base Board Information
         Manufacturer: Intel
         Product Name: SE7320SP2
         Version: FRU V0.01


>> I noticed it doesn't soft reset anymore once the kernel said:
>> ata1.00: limiting speed to MWDMA1:PIO4
> 
> What kind of speed are you getting after that? Perhaps this is an
> acceptable solution...
> (I already ordered an extra adaptec sata controller to work arround
> this whole mess, but it's still interesting)

Well, it's a IDE flash disk (2 GB), so you can imagine... :)

# hdparm -t /dev/sda

/dev/sda:
  Timing buffered disk reads:   28 MB in  3.19 seconds =   8.78 MB/sec

I must say I'm amazed it's so fast.


> Btw, out on a limb here: my board has specific combinations of sata
> port usage leading to a reset. Avoiding to use sata0 (sda) (unplug the
> cable) works perfectly.
> Do you have the same symptoms?

No idea, no SATA here.


-- 
Tomasz Chmielewski
http://wpkg.org
