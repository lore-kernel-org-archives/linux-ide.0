From: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Subject: Re: [PATCH 1/1] AVR32 PATA driver
Date: Tue, 14 Aug 2007 08:53:47 +0200
Message-ID: <200708140853.47371.kngregertsen@norway.atmel.com>
References: <200708071126.08735.kngregertsen@norway.atmel.com> <200708140841.25308.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:50582 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752818AbXHNG4K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Aug 2007 02:56:10 -0400
In-Reply-To: <200708140841.25308.kngregertsen@norway.atmel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: gregerts@stud.ntnu.no, kernel@avr32linux.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, kngregertsen@norway.atmel.com

Hi again everybody,

The driver is now working very nicely. The sporadic errors I reported earlier
were mostly due to the state of the EBI to ATA adaptor prototype card.

I have also added some time before R/W strobe to make sure signals are stable.

The only thing that bothers me is the huge number of interrupts that occurs
during data transfers. There is one interrupt for every ~500 bytes or so:

-sh-3.2# cat /proc/interrupts
	...
 65:   62015176       eic  at32_ide

-sh-3.2# dd if=/dev/zero of=zero.dat count=10k
10240+0 records in
10240+0 records out
-sh-3.2# cat /proc/interrupts
	...
 65:   62025176       eic  at32_ide

Would I be better off using polling mode?
-- 
Kristoffer Nyborg Gregertsen
MSc. student / Summer intern
Atmel Norway
