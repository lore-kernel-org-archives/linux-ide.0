From: "Buehl, Reiner" <reiner.buehl@hp.com>
Subject: RE: ext3 filesystem corruption on md RAID1 device
Date: Thu, 20 May 2010 12:04:41 +0000
Message-ID: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DE37@GVW1115EXC.americas.hpqcorp.net>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
 <4BF521CA.7080503@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:5625 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab0ETMGX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 08:06:23 -0400
In-Reply-To: <4BF521CA.7080503@buttersideup.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

The last regular sync check did not show any inconsistencies. I have started another sync check now and will post the result when it is finished.

Best regards,
Reiner.

> -----Original Message-----
> From: Tim Small [mailto:tim@buttersideup.com]
> Sent: Thursday, May 20, 2010 1:50 PM
> To: Buehl, Reiner
> Cc: linux-ide@vger.kernel.org; linux-fsdevel@vger.kernel.org
> Subject: Re: ext3 filesystem corruption on md RAID1 device
> 
> Buehl, Reiner wrote:
> > The two disks used in the RAID1 md device are both Seagate
> ST31000528AS that show no errors in long and short SMART test and
> Seatools. Memtest shows no memory problems.
> 
> 
> Have you tried:
> 
> echo 'check' > /sys/block/md<whatever>/md/sync_action
> 
> ... that should report discrepancies between the two sides of the
> mirror
> ...  Unfortunately, I don't think it reports which LBAs, but you could
> find this by hand using dd and md5sum or whatever.  After that, if you
> do have discrepancies, then you can investigate what form they take by
> comparing the blocks from the individual block devices, and viewing
> them
> in a hex editor etc. etc.
> 
> 
> 
> Tim.
