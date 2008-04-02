From: "Konstantin A. Lepikhov" <lakostis@unsafe.ru>
Subject: Re: AHCI SATA DVD writing issue
Date: Wed, 2 Apr 2008 14:07:49 +0400
Message-ID: <20080402100749.GA25346@lks.home>
References: <beee72200803200416j2c744450v8b21cf6fe029ff1a@mail.gmail.com> <47EE3A1A.6080406@gmail.com> <beee72200804011526u271d8951m126afd2913748187@mail.gmail.com> <47F2D1DB.5060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:42187 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbYDBKkj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Apr 2008 06:40:39 -0400
Content-Disposition: inline
In-Reply-To: <47F2D1DB.5060207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun!

Wednesday 02, at 09:22:51 AM you wrote:

> Hello, Davor.
> 
> davor emard wrote:
>> Here is capture of the syslog as you requested.
>> I have a LG on ide, and pioneer and optiarc on sata (marvell 6145)
>> (see my "lsscsi.txt")
> 
> Ah... it's a marvell.  MV ahci support is somewhat limited at the moment.
> 
>> First I tried wodim -devices then were lots of ata errors and
>> timeouts and after some time wodim printed "wodim-devices-1.txt"
>> where it recognized LG and pioneer but not optiarc.
>> But next time I run wodim -devices it doesn't
>> recognize even pioneer (only IDE LG drive is listed)
>> "wodim-devices-2.txt"
>> The syslog dump of the above test is in "syslog-devices.txt"
>> 
>> Next I rebooted and tried mounting.
>> First I mounted a CD normally on pioneer. Then I ejected
>> it from pioneer and inserted into optiarc.
>> Interesting that hal daemon printed corrected CD name
>> from optiarc.
>> But then I tried mounting to optiarc, ata errors appeared and
>> mount gave up after long time.
>> Then I ejected from optiarc and tried to mount to pioneer
>> again but this time pioneer doesn't work either -
>> Buffer I/O error on device sr0, logical block 329952
>> See the test in "syslog-mounting.txt"
>> 
>> I also attach my kernel config. I used normal unpatched
>> 2.6.24.4 on amd64, I compiled it myself on debian testing
> 
> Yeah, what happens is that the controller somehow doesn't like certain 
> ATAPI commands (maybe it doesn't really enjoy short or unaligned transfers, 
> both cases are data-in commands w/ 2 byte buffer).
> 
> The port completely locks up afterwards which is unusual for ahci port and 
> more unusually it takes the other port on the controller with it. hald 
> tries to poll the other device and thus the driver issues TUR and ta-da the 
> port is completely dead already.
> 
> Can you please give a shot at 2.6.25-rc8 and post resulting kernel log?  
> Buffer aligning / padding support is improved there.
> 
> Thanks.
> 
I'm found simular report but for intel ahci -
https://bugzilla.altlinux.org/show_bug.cgi?id=15087

Here is lspci -vvnn output
https://bugzilla.altlinux.org/attachment.cgi?id=2543

And the dmesg with timings
https://bugzilla.altlinux.org/attachment.cgi?id=2546

The symptoms looks the same except failed ATAPI commands. I don't know
it's important or not and may we combine this bugs.

It's reproducible with 2.6.24.4 kernel with stock ahci driver. 

-- 
WBR et al.
