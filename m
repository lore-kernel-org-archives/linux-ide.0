From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: Problems with disc-performance and libata
Date: Mon, 27 Aug 2007 01:59:11 +0200
Message-ID: <6bffcb0e0708261659y15b344b7h783a1f5ea43a3899@mail.gmail.com>
References: <1188158937.6896.4.camel@WG4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:6301 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbXHZX7M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Aug 2007 19:59:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1887163wah
        for <linux-ide@vger.kernel.org>; Sun, 26 Aug 2007 16:59:11 -0700 (PDT)
In-Reply-To: <1188158937.6896.4.camel@WG4>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Oliver Janscheidt <oliver.janscheidt@rub.de>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi Oliver,

[Adding linux-ide to CC]

On 26/08/07, Oliver Janscheidt <oliver.janscheidt@rub.de> wrote:
> Hi,
>
> I'm using a Lenovo Thinkpad with TOSHIBA MK1234GS HD and MATSHITA
> DVD-RAM UJ-850 on 82801GBM/GHM (ICH7 Family) Serial ATA Storage
> Controller IDE. The Kernel is a 2.6.22.1 from Kernel.org (with 2.6.23-rc1-
> and hdaps-queue-freezing-patch).

Could you try 2.6.23-rc3-git10?

>
> sudo hdparm -t /dev/scd0 gives
>
> Timing buffered disk reads:    2 MB in  4.47 seconds = 457.75 kB/sec

Are you using cracked cd/dvd?


cracked dvd

/sbin/hdparm -t /dev/scd0

/dev/scd0:
 Timing buffered disk reads:    2 MB in  6.36 seconds = 321.78 kB/sec


new shiny dvd

/sbin/hdparm -t /dev/scd0

/dev/scd0:
 Timing buffered disk reads:   14 MB in  3.14 seconds =   4.46 MB/sec

>
> sudo hdparm -t /dev/sda gives
>
> Timing buffered disk reads:  102 MB in  3.04 seconds =  33.51 MB/sec

I've got an old Maxtor HDD (also 5,400 rpm) results are similar.

>
> which is a quite poor performance and makes any streaming impossible.
> Obviously UDMA is working correctly as dmesg | grep UDMA says:
>
> [   43.636590] ata1: SATA max UDMA/133 cmd 0xffffc20004612500 ctl
> 0x0000000000000000 bmdma 0x0000000000000000 irq 314
> [   43.636595] ata2: SATA max UDMA/133 cmd 0xffffc20004612580 ctl
> 0x0000000000000000 bmdma 0x0000000000000000 irq 314
> [   43.636599] ata3: SATA max UDMA/133 cmd 0xffffc20004612600 ctl
> 0x0000000000000000 bmdma 0x0000000000000000 irq 314
> [   43.636603] ata4: SATA max UDMA/133 cmd 0xffffc20004612680 ctl
> 0x0000000000000000 bmdma 0x0000000000000000 irq 314
> [   44.177980] ata1.00: ATA-7: TOSHIBA MK1234GSX, AH002E, max UDMA/100
> [   44.179192] ata1.00: configured for UDMA/100
> [   44.326918] ata5: PATA max UDMA/133 cmd 0x00000000000101f0 ctl
> 0x00000000000103f6 bmdma 0x0000000000011880 irq 14
> [   44.326922] ata6: PATA max UDMA/133 cmd 0x0000000000010170 ctl
> 0x0000000000010376 bmdma 0x0000000000011888 irq 15
> [   44.571970] ata5.00: ATAPI: MATSHITADVD-RAM UJ-850, RB01, max UDMA/33
> [   44.738552] ata5.00: configured for UDMA/33
> [    0.610332] ata5.00: configured for UDMA/33
> [    0.750296] ata1.00: configured for UDMA/100
>
> Is there any solution for that problem or at least a workaround?
>
> I also tried to recompile the kernel as recommended in the official
> libata-faq ( http://linux-ata.org/faq.html ) but the system stuck when
> booting the root-partition. Booting with combined_mode=libata or
> combined_mode=ide didn't affect the performance, too.
>
> Thanks in advance,
>
> Oli
>

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
