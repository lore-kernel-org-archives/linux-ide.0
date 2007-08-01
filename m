From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 1 Aug 2007 23:43:32 +0100
Message-ID: <20070801234332.3d28f7b2@the-village.bc.nu>
References: <1185880124.3483.25.camel@localhost>
	<46AF76D7.8050800@ru.mvista.com>
	<1185916925.8484.23.camel@orchid.arb.net>
	<200707312332.10820.bzolnier@gmail.com>
	<46B08D63.4040205@ru.mvista.com>
	<1185983536.16340.3.camel@orchid.arb.net>
	<46B0ADB6.60207@ru.mvista.com>
	<1185988529.16340.5.camel@orchid.arb.net>
	<46B0CEC0.60504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57732 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754077AbXHAWg0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 18:36:26 -0400
In-Reply-To: <46B0CEC0.60504@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bob Ham <rah@bash.sh>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

>     Too bad, this is the standard HPT subsystem ID of 0x0001... So, nothing 
> comes to my mind other than add a module parameter to hpt366.c to specify that 
> we're using the crippled SATA bridge... well, maybe it would also make sense 
> to scan the BIOS for the signatures...

Since you don't do a reset is it not sufficient to check word93 on the
initial identify scan in PIO. Or if you do a reset the signature.


