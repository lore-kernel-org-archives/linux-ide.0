From: Tejun Heo <tj@kernel.org>
Subject: Re: using sata_sil24 10.4 2.6.32-25-server x86_64
Date: Sun, 12 Sep 2010 13:04:04 +0200
Message-ID: <4C8CB3A4.8090400@kernel.org>
References: <4C8A4BD6.6090206@gmail.com> <4C8A5398.1010806@kernel.org> <4C8A609F.8040302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50932 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520Ab0ILLEH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Sep 2010 07:04:07 -0400
In-Reply-To: <4C8A609F.8040302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugo Antunes <hugo.antunes@gmail.com>
Cc: linux-ide@vger.kernel.org

(restoring cc to linux-ide@vger.kernel.org.  Please always use
reply-to-all)

Hello,

On 09/10/2010 06:45 PM, Hugo Antunes wrote:
> After boot they stay at 1.5GBs or at least no other message is
> logged to the system, hdparm tells me they are SATA2 1.5 and 3.0Gbs
> capable as expected.

Are you saying that w/ libata.force=1.5Gbps, the error messages are
gone?

> Yes, backplanes, the machine has 9 internal backplanes, currently
> using 3 backplanes (5 hdd's each backplane), 13 disks in use, 2
> sata_sil3124 with 4 ports each, each port conects to one backplane,
> two raid6 md0 md1 (irrelevant for the case if it wasn't for the fact
> that mdadm recovery and resync takes almost 2000mins), this is an
> iscsitarget machine, unable to boot machine and test
> libata.force=1.5Gbps,

What do you mean "unable to boot machine"?  You can't reboot the
machine?  Or you can't try kernel parameters?  How being iscsitarget
makes any difference regarding that?

> "They all indicate that the drives are seeing CRC errors on the
> link.", on the link you meanthe cable, card - sata cable - backplane
> - 5 drives.  so the error is related to all drives right ? currently
> conected to that backplane?

I meant the connection between the port multiplier and the drives;
however they may be connected.  If at all possible (ie. PMP has ports
w/ exposed connectors which currently are connected to backplane), try
to connect the port multiplier to drives using regular SATA cables.
It seems faulty backplanes are not too uncommon.  Also, are the errors
confined to drives attached to any specific backplane or are they all
over the place?

> hdparm -Tt /dev/sdb (disk connected to first backplane)
> 
> Timming cached reads: 9944 MB in 2.00 seconds = 4975.13 MB/sec
> Timming buffered disk reads: 18 MB in 3.05 seconds = 5.90 MB/sec

Yeah, well, if you're getting frequent transmission errors, the
performance is expected to be horrible.

> how can i get more deatiled info or test the link.

I think you'll need to find out which part is causing the problem.
Start with simple test case (ie. parallel dd's) and single port
multiplier with increasing number of drives.  Try different PMPs and
try to find out the pattern of failure.

Thanks.

-- 
tejun
