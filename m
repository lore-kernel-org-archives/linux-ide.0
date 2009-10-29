From: Simon Jackson <sjackson@bluearc.com>
Subject: RE: Drives  freeze on Linux appliances.
Date: Thu, 29 Oct 2009 11:37:35 +0000
Message-ID: <ABFC24E4C13D81489F7F624E14891C865A99992D@uk-ex-mbx1.terastack.bluearc.com>
References: <ABFC24E4C13D81489F7F624E14891C865A9998BB@uk-ex-mbx1.terastack.bluearc.com>
 <20091029111651.1a194f2f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from p01c12o143.mxlogic.net ([208.65.145.66]:43342 "EHLO
	p01c12o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZJ2Lhr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Oct 2009 07:37:47 -0400
In-Reply-To: <20091029111651.1a194f2f@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Thanks Alan.
I posted another snippet from a log on another system which is seeing a similar problem in that a drive seems to have gone for a very long walk.

In the second case the log is after a reboot and the drive is not detected correctly.

I am wondering if there is a single root cause here.

In all I have seen in excess of 20 cases of drives dropping out of RAID on different appliances and in all cases the first signs of problems stem from the timeout followed by an ata reset which succeeds to varying degrees.

Googling has come up with power as an issue for other instances of this type of problem, but again a faulty PSU seems to be unlikely given the number of units affected.

You questioned as to whether smartd is enabled.  The problems have been seen both on systems with smartd enabled and without.




-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: 29 October 2009 11:17
To: Simon Jackson
Subject: Re: Drives freeze on Linux appliances.

> 2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104358] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> 2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104416] ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0
> 2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104417]          res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> 2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104451] ata1.00: status: { DRDY }

For some reason the drive decided it was busy, and stayed that way

> 2009-10-27T11:34:41+00:00 merc-stm2-1 kernel: [1317088.104483] ata1: hard resetting link

We reset the link (which is the right thing to do)
> 2009-10-27T11:34:48+00:00 merc-stm2-1 kernel: [1317095.795176] ata1: link is slow to respond, please be patient (ready=0)
> 2009-10-27T11:34:51+00:00 merc-stm2-1 kernel: [1317099.906167] ata1: softreset failed (device not ready)
> 2009-10-27T11:34:51+00:00 merc-stm2-1 kernel: [1317099.906167] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

link level comes back

> 2009-10-27T11:35:21+00:00 merc-stm2-1 kernel: [1317135.829417] ata1.00: qc timeout (cmd 0xec)
> 2009-10-27T11:35:21+00:00 merc-stm2-1 kernel: [1317135.829426] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> 2009-10-27T11:35:21+00:00 merc-stm2-1 kernel: [1317135.829429] ata1.00: revalidation failed (errno=-5)
> 2009-10-27T11:35:21+00:00 merc-stm2-1 kernel: [1317135.829463] ata1: failed to recover some devices, retrying in 5 secs

but not the drive.

(and we then try again a few more times)

Basically your drive went for a walk and didn't return.

> This was followed by a whole load of scsi device errors and md raid errors.  In this case, a reboot of Linux did not resolve the problem, only after a power cycle of the unit did the device come back to life.

Sounds like the drive firmware crashed.

> The problem has been seen both on Seagate and Hitachi HDDs, so I am inclined to discount a drive issue here.
> Can anyone shed light on what is happening here?

Not immediately. If you have smart monitoring running you might want to
see if turning that off helps. The other sometimes cause of this is power
but it seems odd to run for such a long time if its a power budget
problem. Doesn't feel like it fits the evidence.

