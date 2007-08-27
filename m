From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Mon, 27 Aug 2007 00:11:39 -0700
Message-ID: <46D2792B.401@vc.cvut.cz>
References: <46D2595B.1030409@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:50307 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbXH0HLl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Aug 2007 03:11:41 -0400
In-Reply-To: <46D2595B.1030409@sauce.co.nz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <richard@sauce.co.nz>
Cc: linux-ide@vger.kernel.org

Richard Scobie wrote:
>  > 3726/4726 work very well under high load with most drives.  I guess
>  > you had some problem with the cage.
> 
> Does anyone have any performance figures to share, with these PMP 
> interfaces?

Hello,
   what exactly you are looking for?  For me it behaves exactly as 
intended, and I did not notice any problems.  When I communicate with 
only one harddrive then performance is same as native.  When I 
communicate with more than one drive, then of course bandwidth between 
host and PMP becomes bottleneck.  /dev/sdf is using 1.5Gbps, everybody 
else claims 3.0Gbps.  Not that I see any difference :-(

Though I do not run any RAID on them (I would say that with PMP's 
bottleneck it would be bad idea), so maybe I'm not stressing them 
sufficiently to trip over bugs.

/dev/sda: 320GB Hitachi on sata_nv
/dev/sdb: 1TB Hitachi on sata_sil24 + 3726 (Sans Digital MS4UM)
/dev/sdc: 750GB Seagate on sata_sil24 + 3726
/dev/sdd: 1TB Hitachi on sata_sil24 + 3726
/dev/sde: 750GB Seagate on sata_sil24 + 3726
/dev/sdf: Sans Digital MS2UT with two 750GB in RAID1 on second sil24 port

gwy:~# for a in /dev/sd[abcdef]; do hdparm -t $a; done

/dev/sda:
  Timing buffered disk reads:  214 MB in  3.01 seconds =  71.07 MB/sec

/dev/sdb:
  Timing buffered disk reads:  236 MB in  3.00 seconds =  78.58 MB/sec

/dev/sdc:
  Timing buffered disk reads:  220 MB in  3.02 seconds =  72.74 MB/sec

/dev/sdd:
  Timing buffered disk reads:  240 MB in  3.02 seconds =  79.41 MB/sec

/dev/sde:
  Timing buffered disk reads:  218 MB in  3.00 seconds =  72.64 MB/sec

/dev/sdf:
  Timing buffered disk reads:  226 MB in  3.02 seconds =  74.95 MB/sec

Apparently 1TB Hitachis are slightly faster than 750GB Seagates...

gwy:~# hdparm -t /dev/sdb & hdparm -t /dev/sdd & sleep 20
(reformatted to show values in order, not interleaved)

/dev/sdd:
  Timing buffered disk reads:  158 MB in  3.02 seconds =  52.40 MB/sec

/dev/sdb:
  Timing buffered disk reads:  168 MB in  3.02 seconds =  55.68 MB/sec

gwy:~# hdparm -t /dev/sdc & hdparm -t /dev/sde & sleep 20

/dev/sde:
  Timing buffered disk reads:  168 MB in  3.01 seconds =  55.89 MB/sec

/dev/sdc:
  Timing buffered disk reads:  150 MB in  3.01 seconds =  49.77 MB/sec

gwy:~# hdparm -t /dev/sdb & hdparm -t /dev/sdc & hdparm -t /dev/sdd & 
hdparm -t /dev/sde & sleep 20

/dev/sde:
  Timing buffered disk reads:   98 MB in  3.02 seconds =  32.46 MB/sec

/dev/sdd:
  Timing buffered disk reads:  100 MB in  3.06 seconds =  32.73 MB/sec

/dev/sdc:
  Timing buffered disk reads:   92 MB in  3.07 seconds =  30.01 MB/sec

/dev/sdb:
  Timing buffered disk reads:  118 MB in  3.05 seconds =  38.75 MB/sec

gwy:~# hdparm -t /dev/sdb & hdparm -t /dev/sdf & sleep 20

/dev/sdb:
  Timing buffered disk reads:  194 MB in  3.02 seconds =  64.31 MB/sec

/dev/sdf:
  Timing buffered disk reads:  224 MB in  3.02 seconds =  74.09 MB/sec

gwy:~# hdparm -t /dev/sda & hdparm -t /dev/sdb & hdparm -t /dev/sdc & 
hdparm -t /dev/sdd & hdparm -t /dev/sde & hdparm -t /dev/sdf & sleep 20

/dev/sda:
  Timing buffered disk reads:  200 MB in  3.03 seconds =  66.00 MB/sec

/dev/sdf:
  Timing buffered disk reads:  220 MB in  3.05 seconds =  72.11 MB/sec

/dev/sde:
  Timing buffered disk reads:   58 MB in  3.03 seconds =  19.12 MB/sec

/dev/sdd:
  Timing buffered disk reads:   64 MB in  3.04 seconds =  21.06 MB/sec

/dev/sdb:
  Timing buffered disk reads:   70 MB in  3.03 seconds =  23.10 MB/sec

/dev/sdc:
  Timing buffered disk reads:   56 MB in  3.01 seconds =  18.59 MB/sec

gwy:~#


For comparsion 1TB Hitachi behind 3726 PMP (again MS4UM) with sata_sil 
patch I sent last week (no NCQ, 1.5Gbps link between 3512 and PMP, and 
3.0Gbps link between PMP and drive... why is it faster?):

petr-dev3:~# hdparm -t /dev/sdd

/dev/sdd:
  Timing buffered disk reads:  248 MB in  3.01 seconds =  82.48 MB/sec

petr-dev3:~#

							Petr


