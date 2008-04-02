From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI SATA DVD writing issue
Date: Wed, 02 Apr 2008 09:22:51 +0900
Message-ID: <47F2D1DB.5060207@gmail.com>
References: <beee72200803200416j2c744450v8b21cf6fe029ff1a@mail.gmail.com>	 <47EE3A1A.6080406@gmail.com> <beee72200804011526u271d8951m126afd2913748187@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:61076 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbYDBAW6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 20:22:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2892527wah.23
        for <linux-ide@vger.kernel.org>; Tue, 01 Apr 2008 17:22:57 -0700 (PDT)
In-Reply-To: <beee72200804011526u271d8951m126afd2913748187@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davor emard <davoremard@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>

Hello, Davor.

davor emard wrote:
> Here is capture of the syslog as you requested.
> I have a LG on ide, and pioneer and optiarc on sata (marvell 6145)
> (see my "lsscsi.txt")

Ah... it's a marvell.  MV ahci support is somewhat limited at the moment.

> First I tried wodim -devices then were lots of ata errors and
> timeouts and after some time wodim printed "wodim-devices-1.txt"
> where it recognized LG and pioneer but not optiarc.
> But next time I run wodim -devices it doesn't
> recognize even pioneer (only IDE LG drive is listed)
> "wodim-devices-2.txt"
> The syslog dump of the above test is in "syslog-devices.txt"
> 
> Next I rebooted and tried mounting.
> First I mounted a CD normally on pioneer. Then I ejected
> it from pioneer and inserted into optiarc.
> Interesting that hal daemon printed corrected CD name
> from optiarc.
> But then I tried mounting to optiarc, ata errors appeared and
> mount gave up after long time.
> Then I ejected from optiarc and tried to mount to pioneer
> again but this time pioneer doesn't work either -
> Buffer I/O error on device sr0, logical block 329952
> See the test in "syslog-mounting.txt"
> 
> I also attach my kernel config. I used normal unpatched
> 2.6.24.4 on amd64, I compiled it myself on debian testing

Yeah, what happens is that the controller somehow doesn't like certain 
ATAPI commands (maybe it doesn't really enjoy short or unaligned 
transfers, both cases are data-in commands w/ 2 byte buffer).

The port completely locks up afterwards which is unusual for ahci port 
and more unusually it takes the other port on the controller with it. 
hald tries to poll the other device and thus the driver issues TUR and 
ta-da the port is completely dead already.

Can you please give a shot at 2.6.25-rc8 and post resulting kernel log? 
  Buffer aligning / padding support is improved there.

Thanks.

-- 
tejun
