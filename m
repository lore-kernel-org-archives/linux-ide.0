From: Tejun Heo <htejun@gmail.com>
Subject: Re: satapii vs ahci
Date: Mon, 27 Mar 2006 12:01:55 +0900
Message-ID: <20060327030155.GA11047@htj.dyndns.org>
References: <5d96567b0603261305l5a745a6x786bea846e6902ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.224]:9544 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751124AbWC0UVn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2006 15:21:43 -0500
Received: by wproxy.gmail.com with SMTP id i28so1514815wra
        for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 12:21:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5d96567b0603261305l5a745a6x786bea846e6902ed@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Mar 26, 2006 at 11:05:33PM +0200, Raz Ben-Jehuda(caro) wrote:
> Hello guys.
> I have been testing performance of 4 maxtor disks combined as
> raid0 . the test was of reading random 1M ios all over the raid
> in asynchrnous IO mode.
> ahci bits satapii by 50% . while satapii gives 80MB/s ahci gives
> over 120 MB/s .
> 
> Why is that ? what is the difference between the two ?
> 

If your BIOS programmed your controller in such way that two SATA
ports share a controller (ie. SATA P0 is primary master while SATA P1
is primary secondary), two ports should serialize, so the lower
throughput.  Try to choose other legacy mode.  My BIOS puts each port
into different controller if I put it into Enhanced mode, but YMMV.
And, next time, don't forget dmesg.

-- 
tejun
