From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710, pcmcia based sata_sil24, PMP, and NCQ drive
Date: Tue, 29 Aug 2006 10:07:18 -0400
Message-ID: <87f94c370608290707s57390e10o8742e0e5eb103e5d@mail.gmail.com>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:15667 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964982AbWH2OHU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 10:07:20 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1987850ugc
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2006 07:07:18 -0700 (PDT)
In-Reply-To: <44F3A8FD.6090108@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Derek Taubert <taubert@geeks.org>, linux-ide@vger.kernel.org

On 8/28/06, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> Derek Taubert wrote:
> > What doesn't work so well:
> >
> > 1) Writing to sda1.
> >
> > # dd if=/dev/zero of=/dev/sda1 count=4M
> > <ctrl-c, then wait 30 seconds>
> > 264205+0 records in
> > 264204+0 records out
> > 135272448 bytes (135 MB) copied, 111.373 seconds, 1.2 MB/s
> >
> > From iostat -k 10:
> > Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
> > sda            2428.64      2422.46       667.66      24273       6690
> > sda              36.84        23.72      1667.87        237      16662
> > sda            2440.60      2434.90       616.00      24349       6160
> > The read rate is curious (should be 0)...

Tejun already asked you to change the dd line, but I'm pretty sure it
is the culprit, not a kernel bug.  I always use a bs=4k arg for dd on
x86 boxes.  Not sure of the detais, but it often makes a huge
performance change and eliminates all those wasteful reads.

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
