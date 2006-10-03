From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA repeated failure (command 0x35 timeout, status 0xd8)
Date: Tue, 03 Oct 2006 15:54:53 +0900
Message-ID: <4522093D.9040506@gmail.com>
References: <62b0912f0609240816q54c3535bt86f781745ecbfa13@mail.gmail.com>	 <4518B643.6030407@gmail.com> <62b0912f0610011927k789b63f4r370b419e5b98bb5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:53619 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965273AbWJCGyq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Oct 2006 02:54:46 -0400
Received: by py-out-1112.google.com with SMTP id n25so2826151pyg
        for <linux-ide@vger.kernel.org>; Mon, 02 Oct 2006 23:54:45 -0700 (PDT)
In-Reply-To: <62b0912f0610011927k789b63f4r370b419e5b98bb5f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Molle Bestefich wrote:
[--snip--]
> The above repeats itself thru modes UDMA/66, UDMA/44, UDMA/33,
> UDMA/25, UDMA/16, PIO4, PIO3, PIO1 and PIO0.

Can you full dmesg for this?  Preferably w/ timestamp?

> At which point /dev/sdb disappears completely, only to reappear as 
> /dev/sdh:
> ===============
> SCSI device sdh: 398297088 512-byte hdwr sectors (203928 MB)
> sdh: Write Protect is off
> sdh: Mode Sense: 00 3a 00 00
> SCSI device sdh: drive cache: write back
> SCSI device sdh: 398297088 512-byte hdwr sectors (203928 MB)
> sdh: Write Protect is off
> sdh: Mode Sense: 00 3a 00 00
> SCSI device sdh: drive cache: write back
> ===============
> 
> (Odd.)
> 
> I don't get why PowerMax works this drive just fine while Linux
> doesn't.  Perhaps because PowerMax only uses SMART commands and
> doesn't transfer data over the SATA bus?
> 
> Anyway, with the device now failing fairly consistently, I guess I
> should begin moving around cables, controllers, disks etc. again.  I'm
> very worried about doing this though, since I'm pretty sure that it'll
> break the MD array on the disks very quickly..

Your problem seems to be hardware transmission error.  I don't know what 
a powermax is and doesn't know what it does, so you'll have to play the 
swap-and-see-what-breaks game to figure out the problematic part.

Thanks.

-- 
tejun
