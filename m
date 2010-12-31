From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: PMP 3726 problem?
Date: Fri, 31 Dec 2010 06:56:37 -0600
Message-ID: <4D1DD305.1020701@hardwarefreak.com>
References: <AANLkTi=6yROpG+nXHYPqHwbQucwQqmrai9yCyx=GFCPG@mail.gmail.com> <4D1BDB10.803@hardwarefreak.com> <AANLkTik+U4eh3bqx5oJ0wxU8+sJogGV+-tPzMTycSPTd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:49352 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab0LaM4i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Dec 2010 07:56:38 -0500
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 2F5576C0B8
	for <linux-ide@vger.kernel.org>; Fri, 31 Dec 2010 06:56:37 -0600 (CST)
In-Reply-To: <AANLkTik+U4eh3bqx5oJ0wxU8+sJogGV+-tPzMTycSPTd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Phill Jolliffe put forth on 12/30/2010 3:40 PM:

>> 1.  Have you tried the PCIe x1 eSATA card that came bundled with your
>> unit?  Does it work properly using that card?
> 
> Switched from the mobo's built in esata port to bundled card. All 4
> sata drives are detected without fault on each of 5 trial reboots.

That's a good.  Tells us the enclosure works.

> I had avoided using the bundled card and used the mobo builtin esata +
> md sw raid as I need the single PCIe slot on my mobo for a graphics
> card.

That's bad.  I hate to be the bearer of bad news, but I'm pretty sure
you are screwed.  According to Google results, which are slim pickens,
it seems the Intel H55 chipset does not support FIS based switching,
which means none of your mobo e/SATA  ports will work with a PMP.

If you really _need_ a PCIe GPU (which baffles me as you're running
Linux, and you have VGA, DVI, *and* HDMI outputs on the mobo), then it
appears a USB 3 external enclosure is most certainly in your future.
Frankly I'm surprised you didn't purchase one with both eSATA and USB 3
ports to begin with, just in case you ran into what you just did.

-- 
Stan
