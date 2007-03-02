From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [RFT] sata_promise: intermittent errors bug hunting
Date: Fri, 2 Mar 2007 13:52:11 +0100 (MET)
Message-ID: <200703021252.l22CqB7I026196@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:35680 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945905AbXCBMwQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 07:52:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi.Orava@ncircle.nullnet.fi
Cc: linux-ide@vger.kernel.org

On Fri, 2 Mar 2007 13:51:19 +0200 (EET), Tomi Orava wrote:
> > There have been some reports of intermittent errors
> > with sata_promise, especially with newer disks.
> > My theory is that the driver isn't initialisating the
> > controller properly for SATAII 3Gbps transfer speeds.
> 
> I did a test run with 2.6.21-rc2-git1 & your patch and
> still got similar errors as without your patch ...
> 
> My hardware consists of Promise PDC40718 (SATA 300 TX4)
> 4-port sata-card & 2 older 7200.7 Seagates (200GB) and
> 2 newer 7200.10 Seagates (500GB).
> 
> It's only the 7200.10 models which creates the following type of
> complaints in the system logs:
> 
> Mar  2 11:13:40 alderan kernel: ata2.00: exception Emask 0x0 SAct 0x0 SEr=
> r
> 0x0 action 0x0
> Mar  2 11:13:40 alderan kernel: ata2.00: cmd
> 25/00:00:3f:6f:a1/00:02:07:00:00/e0 tag 0 cdb 0x0 data 262144 in
> Mar  2 11:13:40 alderan kernel:          res
> 50/00:00:3e:71:a1/00:00:9e:03:76/e0 Emask 0x1 (device error)
etc

Thanks for testing. Did you see my second patch to improve
error decoding and reporting in sata_promise? It would be very
interesting to see what additional information it logs.

<http://marc.theaimsgroup.com/?l=linux-ide&m=117271432801920&w=2>
is the patch I'm referring to.

/Mikael
