From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem with pata_amd/sata_nv on ASRock Penryn1600SLI-110dB board
Date: Thu, 06 Mar 2008 17:32:50 +0900
Message-ID: <47CFAC32.6000103@gmail.com>
References: <20080224225322.061dc654@alkaid.a.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:28997 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbYCFIc6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 03:32:58 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2129858wah.23
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 00:32:57 -0800 (PST)
In-Reply-To: <20080224225322.061dc654@alkaid.a.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Bierfert <andreas.bierfert@lowlatency.de>
Cc: linux-ide@vger.kernel.org

Andreas Bierfert wrote:
> Hi there,
> 
> I got the above mentioned board [1] two weeks ago with a Q6600 cpu. I am running
> Fedora 8 x86_64. While using 2.6.23, the attached cdrom/dvd drives went all
> crazy together with a nice error message of the hdd from time to time.
> 
> After switching to 2.6.24 the cd drives were useful again but the hdd error
> still occurs, effectively in the worst case making the system fs unusable and
> requiring a hard reset. The error seems to appear randomly and I cannot
> reproduce it by causing e.g. high disk usage...
> 
> See http://lowlatency.de/kbug/{dmesg,error,lspci} for the 2.6.23 and
> http://lowlatency.de/kbug/{dmesg,error,lspci}-2.6.24 for the corresponding logs.
> 
> I first thought the bug was related to the pata drives so I switched some drives
> around to only have sata hdds and only the cd/dvd drives on the pata controller
> (see http://lowlatency.de/kbug/dmesg-newest). Still the same error (just other
> ata numbers of course) for the hdd. Just to note => it also is a different
> hdd so I would rule out defective hardware. Current setup is with these
> harddisks http://lowlatency.de/kbug/hdparamI and I am still seeing the error.
> 
> Also tried with noapic parameter set at boot time.
> 
> Would be cool if anyone has some clues. If more information or tests are needed
> let me know.
> 
> Best Regards,
> Andreas Bierfert
> 
> [1] - http://www.asrock.com/mb/overview.asp?Model=Penryn1600SLI-110dB

Does running "hal-disable-polling /dev/sr0" and "hal-disable-polling
/dev/sr1" after boot remove the problems and keep the drives usable?

-- 
tejun
