From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Thu, 02 Aug 2007 16:41:04 +0400
Message-ID: <46B1D0E0.20503@ru.mvista.com>
References: <1185880124.3483.25.camel@localhost>	<46AF76D7.8050800@ru.mvista.com>	<1185916925.8484.23.camel@orchid.arb.net>	<200707312332.10820.bzolnier@gmail.com>	<46B08D63.4040205@ru.mvista.com>	<1185983536.16340.3.camel@orchid.arb.net>	<46B0ADB6.60207@ru.mvista.com>	<1185988529.16340.5.camel@orchid.arb.net>	<46B0CEC0.60504@ru.mvista.com> <20070801234332.3d28f7b2@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37253 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755008AbXHBMjG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 08:39:06 -0400
In-Reply-To: <20070801234332.3d28f7b2@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bob Ham <rah@bash.sh>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
>>    Too bad, this is the standard HPT subsystem ID of 0x0001... So, nothing 
>>comes to my mind other than add a module parameter to hpt366.c to specify that 
>>we're using the crippled SATA bridge... well, maybe it would also make sense 
>>to scan the BIOS for the signatures...

> Since you don't do a reset is it not sufficient to check word93 on the

    Ah, you mean to identify a SATA drive?  Need to try this...

> initial identify scan in PIO. Or if you do a reset the signature.

    Hm, the taskfile signature, you mean?..

MBR, Sergei

