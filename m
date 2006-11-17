From: Jarno Manninen <jarno.manninen@tut.fi>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using libata
Date: Fri, 17 Nov 2006 20:49:48 +0200
Message-ID: <200611172049.49260.jarno.manninen@tut.fi>
References: <11637151391017-git-send-email-tnt@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:41604 "EHLO
	pne-smtpout3-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1755813AbWKQStn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Nov 2006 13:49:43 -0500
In-Reply-To: <11637151391017-git-send-email-tnt@246tNt.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-embedded@ozlabs.org
Cc: Sylvain Munaut <tnt@246tnt.com>, Linux IDE <linux-ide@vger.kernel.org>, Sven Luther <sl@bplan-gmbh.de>

On Friday 17 November 2006 00:12, Sylvain Munaut wrote:

> * The manual states we should check for the TIP bit before all
> PIO transaction. That's not really supported by libata and requires
> reimplementing almost all the hooks. But after talking to Freescale,
> it turnsout it's not really necessary. So this driver doesn't implement
> that check. I noticed no problem so far ...

I've had some bad experiences with 2.4 line kernel when using BAPI 2.2 on Rev. 
A 5200 while imposing heavy I/O load. Problems manifested as hanging XLB-bus 
and so on. Funny thing is that combinations like Rev.A + BAPI 2.1 and Rev.B + 
BAPI 2.[12] seem to be immune while doing similar stress tests.

Problems went away after wrapping PIO access like this:

1. Stop XLB-pipelining
2. Wait for TIP bit to go down.
3. Do the access
4. Restore XLB-pipelining.

Just polling for the TIP bit is not enough due to errata on Rev. A if the 
pipelining is enabled.

Just in case if someone else is having mysterious hangs on Rev.A:s with newer 
microcode. :)

- Jarno

