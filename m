From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Tue, 31 Jul 2007 21:52:23 +0400
Message-ID: <46AF76D7.8050800@ru.mvista.com>
References: <1185880124.3483.25.camel@localhost> <46AF3939.8020805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:13245 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763734AbXGaRuY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jul 2007 13:50:24 -0400
In-Reply-To: <46AF3939.8020805@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

>> I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controller for
>> a while now, using a proprietary binary driver from Highpoint in a linux
>> 2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes on
>> boot, as reported by others.

>    Can we see a bootlog please?

    ... and the output of 'lspci -v' too. I wonders if R1540 could be 
identified via the subsystem ID -- SATA bridges HPT uses seem to have 
limitations WRT DMA modes, i.e. no MWDMA and UDMA modes 0, 4 and higher only 
are supported...

>> Cheers,
>> Bob Ham

MBR, Sergei
