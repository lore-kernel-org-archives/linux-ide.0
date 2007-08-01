From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 01 Aug 2007 19:58:46 +0400
Message-ID: <46B0ADB6.60207@ru.mvista.com>
References: <1185880124.3483.25.camel@localhost>	 <46AF76D7.8050800@ru.mvista.com> <1185916925.8484.23.camel@orchid.arb.net>	 <200707312332.10820.bzolnier@gmail.com>  <46B08D63.4040205@ru.mvista.com> <1185983536.16340.3.camel@orchid.arb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:24727 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752288AbXHAP4s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 11:56:48 -0400
In-Reply-To: <1185983536.16340.3.camel@orchid.arb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Bob Ham wrote:

>>>>>>>I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controller for
>>>>>>>a while now, using a proprietary binary driver from Highpoint in a linux
>>>>>>>2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes on
>>>>>>>boot, as reported by others.

>>>>>>  Can we see a bootlog please?

>>>>>   ... and the output of 'lspci -v' too.

>>    If possible, turn off that driver, 
>>then post that output...

> This is the output of the boot using the pata_hpt37x driver:

    Hrm... what I asked for was 'lspci -v' output. :-)

> hpt37x: DPLL did not stabilize.
> pata_hpt37x: BIOS has not set timing clocks.
> hpt37x: DPLL did not stabilize.

   Yes, this ia a known issue, and the fix for it is in the -mm tree:

http://kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fpeople%2Fakpm%2Fpatches%2F2.6%2F2.6.23-rc1%2F2.6.23-rc1-mm2%2F2.6.23-rc1-mm2.bz2;z=950

WBR, Sergei
