From: Tejun Heo <tj@kernel.org>
Subject: Re: [smartmontools-support] SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Sat, 06 Feb 2010 12:39:31 +0900
Message-ID: <4B6CE473.7060901@kernel.org>
References: <4B6C2635.105@buttersideup.com> <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan> <4B6C2BC8.7000609@buttersideup.com> <4B6C91F3.5090809@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51797 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160Ab0BFIIh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Feb 2010 03:08:37 -0500
In-Reply-To: <4B6C91F3.5090809@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tim Small <tim@buttersideup.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

Hello,

On 02/06/2010 06:47 AM, Mark Lord wrote:
>> 2. A few failures were seen with the Seagate drives as well (see last
>> bits of the email), similarly with no apparent bad SMART attributes.
> ..
> 
> I have observed (and reported) the same issue in the past,
> on Hitachi and Seagate drives.
> 
> The only constants seem to be libata and ICH7/8.
> We must have a bug somewhere in there.

In piix mode or ahci mode?  If in piix mode, ich7 and 8 would behave
quite differently.  ICH8 has SIDPR so it can hardreset while 7 can't.
ICH SIDPR access had a hardware problem where write to SControl to
clear DET is sometimes ignored which led to occassional hardreset
failure which got fixed recently.  The reason why ich's are involved
in those incidents could just be that they are extremely popular.

Things to try after such completely drive shutdown are...

* Disconnect the drive from the host but do not remove power.
  Reconnect the drive to a different port and/or controller, does the
  drive work there?

* Power-cycle the drive (and issue manual rescan if necessary).  Does
  the drive get recognized again?

* Disconnect the drive and connect a different drive to the port.
  Does the port work?

* Soft reset the machine.  Can BIOS recognize the drive?

In many cases I've seen, it's usually that the drive's firmware is
completely hung and only power cycling the drive brought it back.  But
then again, there have been some number of cases which didn't get
diagnosed properly, so it's definitely possible that we're doing
something wrong in the driver.

Anyways, if it happens again, please try the above and try to find out
whether the controller or the drive is hung.  Also, please keep in
mind that timeouts on 0xEA (flush) is very often indicative of power
related issues.  FLUSH spikes power consumption and surprisingly many
PSUs fail to sustain proper voltage over that, so powering up a
separate PSU and connecting only the hard drive to it and see what
happens is often interesting too.

Thanks.

-- 
tejun
