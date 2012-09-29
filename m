From: Gene Heskett <gheskett@wdtv.com>
Subject: Re: sata adapter
Date: Sat, 29 Sep 2012 08:55:54 -0400
Message-ID: <201209290855.54621.gheskett@wdtv.com>
References: <201209281704.44471.gheskett@wdtv.com> <20582.53793.610242.797773@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wdtv.com ([66.118.69.84]:50433 "EHLO mail.wdtv.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964836Ab2I2Mz5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Sep 2012 08:55:57 -0400
In-Reply-To: <20582.53793.610242.797773@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

On Saturday 29 September 2012 08:13:26 Mikael Pettersson did opine:

> Gene Heskett writes:
>  > Greetings all;
>  > 
>  > I have a nearly 30 year old computer that has an aftermarket scsi
>  > adapter plugged into it.  Unforch the scsi2 drives I have are
>  > suffering from stiction and will only start if given a tap
>  > sufficient to break the seal between the disks and the heads.
>  > 
>  > So, what I am looking for is a scsi2 (50 pin) adapter so I can use a
>  > more modern sata drive on it.
>  > 
>  > Is there such a beast, and if so, where can I buy it in the US?
> 
> I was in a similar situation myself recently.  I have seen a
> scsi-to-sata adapter somewhere once, but it was a very niche and
> expensive product. There are cheap scsi 50/68/80-pin adapters out there
> however (try google), allowing you to connect a semi-modern scsi drive
> to an old 50-pin interface.
> 
> If you do find an inexpensive scsi 50-pin to sata adapter then please
> let us know about it ...
> 
> /Mikael

I'd be glad too, but google seems to be mute on the subject.

I did find an IDE to dual SATA adapter, at $7.95 USD a copy, but using that 
would need an IDE kit for the same computer, which is currently going for 
$110 USD.

However, this kit also supports a CF card that can be partitioned into 4 
virtual drives, and could hold every byte of every program ever written for 
this machine.  But that also has the same problem as the HD, limited 
lifetime and recently, poor availability too.  And when I am working on a 
driver for this machine, such as its mouse driver (old MS/Logitech serial 
protocol, I autoswitch modes to make it work correctly), I would use up a 
serious amount of the CF's lifetime with the numerous re-writes of the src 
assembly code.

This machine and OS (it, OS9, now Nitros9, user supported & faster, is a 
mini unix) are like many of the older ones, its maximum drive size is I 
believe 4Gb including all partitions.  With 1Gb, to use the whole drive, 
the minimum file allocation size is 16, 256 byte sectors for a 1 byte file.  
This is caused by its single FAT, which is limited to 65536 bytes.  But we 
normally set a 1Gb drive up as 500 megs for OS9, then 256 more virtual 
disks for the original rsdos 160k format images.  That doesn't use all the 
drive by quite a bit but its a great plenty for us.

So we're still having a discussion with myself.  Another possibility is by 
using drivewire, a program written in java, I believe its possible to 
actually boot that machine from an image maintained as a file on one of the 
4 1Tb drives in this machine.  To get it started is a chicken/egg problem 
but it can be done.
Cheers, Gene
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
My web page: <http://coyoteden.dyndns-free.com:85/gene> is up!
Put cats in the coffee and mice in the tea!
