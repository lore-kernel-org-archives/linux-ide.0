From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci.c: fix ati sb600 sata IRQ_TF_ERR
Date: Fri, 07 Sep 2007 10:24:17 +0900
Message-ID: <46E0A841.3090300@gmail.com>
References: <5767b9100703140222k79dbed9dq6419b4f35d276242@mail.gmail.com>	 <45F7E7E9.6010703@gmail.com>	 <5767b9100703150500t1c34dfb0kc6a199b5374a8d78@mail.gmail.com>	 <45F93888.1080207@gmail.com> <5767b9100703270253j2ac3b543y499323b42c6402b@mail.gmail.com> <46CCA483.4080105@aj.net-lab.net> <46CCB23E.1000506@aj.net-lab.net> <46CD692D.3070508@aj.net-lab.net> <46CF92E2.8080207@gmail.com> <46D2298E.7010105@gmail.com> <46DDE7E7.5030605@net-lab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:18084 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932344AbXIGBYZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 21:24:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so293415rvb
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 18:24:25 -0700 (PDT)
In-Reply-To: <46DDE7E7.5030605@net-lab.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas John <aj@net-lab.net>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Conke Hu <conke.hu@gmail.com>, Neil Brown <neilb@suse.de>

[restoring cc list, please don't drop them]

Andreas John wrote:
> Hi,
> sorry for replying not quicker, but I just wanted to re-test all the
> theories.
> 
> 1. I was not able to reproduce the problem with 2.6.22 ubuntu gutsy
> (amd64 and i386). I ran checkarray --all many many times together with
> dds, but didnt tigger the bug. (even with a second new board!)
> 
> 2. The only explaination I have is that the sata connector on the HDD
> itself had some "plaque" on it (production?)
> 
> 3. The 1.5GB Sata jumper made no difference - that was our 1st try.

Hmmm.... Well, probably caused by faulty hardware or cosmic rays. :-P

> 4. I think the board can do MSI, as the test above shows

Not sure.  IRQ messages don't seem to indicate MSI is in use.  Have you
enabled it in the kernel config?

> 5. I still dont know _why_ the problem ocurred. By now I have about 5
> machines in production - no crash. Another two observations:
>   a) If mdX is sync'ing, the machines somestimes locks up for 5-100 secs

Does kernel say anything during this lock up?

>   b) If you hotplug a hdd (pull out) you get a sata "frozen" line in the
> log. Then e.g. md0 sets the disk to faulty, but the same disk (other
> partition) is still marked active on md1. It gets removeed, on 1st
> access on md1. Is that the intended behavior? Or should I file a bug?
> Where? Neil?

Currently, there's no mechanism to notify unplug to md inside the
kernel.  It can probably done via udev trick or some such.  Cc'd Neil
for advice.

Thanks.

-- 
tejun
