From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: no DRQ after issuing MULTWRITE_EXT ?
Date: Thu, 01 Feb 2007 16:06:21 +0300
Message-ID: <45C1E5CD.8010707@ru.mvista.com>
References: <45C1B079.3080704@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53913 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422849AbXBANGZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 08:06:25 -0500
In-Reply-To: <45C1B079.3080704@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

Hello.

Steven Scholz wrote:

> I am seeing kernel messages like

> [ 1284.480000] hda: status timeout: status=0xd0 { Busy }
> [ 1284.480000] ide: failed opcode was: unknown
> [ 1284.480000] hda: no DRQ after issuing MULTWRITE_EXT
> [ 1284.490000] ide0: unexpected interrupt, status=0x80, count=1
> [ 1284.830000] ide0: reset: success

    Looks like a spurious interrupt... Is your IDE IRQ shared with other devices?

> with a 2.5" Seagate ST940813AM on my embedded ARM system (linux 2.6.14, no
> IDE controller. HDD registers just memory mapped).

> HDD is used in PIO4 with MultSect=16.

> What exactly does that mean? Only that the HDD is to slow to answer this
> request with 100ms (WAIT_DRQ=(HZ/10))?

    Doubt it. The old ATA standard specified the maximum DRQ assertion time of 
20 ms.

> And will the request issued again after the reset of the drive?

    It should be.

MBR, Sergei
