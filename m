From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla
 2.6.23.12 and gentoo-sources 2.6.23-r3
Date: Sun, 13 Jan 2008 13:12:01 +0000
Message-ID: <20080113131201.7a06d38a@lxorguk.ukuu.org.uk>
References: <200801051734.18088.marc@fallon.classyad.com>
	<Pine.LNX.4.64.0801100741580.6632@classyad.com>
	<47861B05.2010201@gmail.com>
	<200801121542.34435.bzolnier@gmail.com>
	<Pine.LNX.4.64.0801130031370.6579@classyad.com>
	<4789A922.40005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40042 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751399AbYAMNOg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 08:14:36 -0500
In-Reply-To: <4789A922.40005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Marc Howard Zuckman <marc@classyad.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


> $ hdparm --Istdin < hdparm.out
> ATA device, with non-removable media
>         Model Number:       Integrated Technology Express Inc
>         Serial Number:     G!
> Standards:
>         Likely used: 1
> Configuration:
>         Logical         max     current
>         cylinders       0       0
>         heads           0       0
>         sectors/track   0       0
>         --
>         device size with M = 1024*1024:           0 MBytes
>         device size with M = 1000*1000:           0 MBytes
> Capabilities:
>         IORDY not likely
>         Cannot perform double-word IO
>         R/W multiple sector transfer: not supported
>         DMA: not supported
>         PIO: pio0
> 
> The only thing which matches the number of sectors is at word 100 which
> is in reserved area.  What's going on here?

Looks totally corrupt. Functioning ITE firmware RAID produces a fairly
poor response which is why we fix up the DMA flag but does report the
volume size correctly.

What firmware rev is this mess coming from ?

Tejun - some of the reserved words indicate raid info, see the way the
driver uses them to report raid type/size.

Alan
