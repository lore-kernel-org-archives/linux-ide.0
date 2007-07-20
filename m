From: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Subject: Re: PATA driver for Atmel AVR32
Date: Fri, 20 Jul 2007 13:01:01 +0200
Message-ID: <200707201301.01514.kngregertsen@norway.atmel.com>
References: <200707201108.19174.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:52180 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753111AbXGTLBi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 07:01:38 -0400
In-Reply-To: <200707201108.19174.kngregertsen@norway.atmel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kernel@avr32linux.org, gregerts@stud.ntnu.no, kngregertsen@norway.atmel.com

On Friday 20 July 2007 11:08:19 Kristoffer Nyborg Gregertsen wrote:
> There might be problems with the signals from the AVR32s External Bus 
> Interface to the ATA device, although it seems fine when looking with the 
> logic analyzer. Can a random signal fault generate this kind of failure? Or 
> is it my driver code that is to blame?

OK, here's an update. The problem seems to be sporadic signal errors:

# dd if=/dev/zero of=/dev/sda2 count=50k
# dd if=/dev/sda2 of=disk.dat count=50k

The read fails somwhere during this read, but nevermind...

# hexdump disk.dat

0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0076bf0 0000 0000 0000 0000 0000 0000 0000 00d0
0076c00 0000 0000 0000 0000 0000 0000 0000 0000
*
00debf0 0000 0000 0000 0000 0000 0000 0000 00d0
00dec00 0000 0000 0000 0000 0000 0000 0000 0000
*
00fc1f0 0000 0000 0000 0000 0000 0000 00d0 00d0
00fc200 0000 0000 0000 0000 0000 0000 0000 0000
*
00fc3f0 0000 0000 0000 0000 0000 0000 0000 00d0
00fc400 0000 0000 0000 0000 0000 0000 0000 0000
*
01021f0 0000 0000 0000 0000 0000 0000 0000 00d0
0102200 0000 0000 0000 0000 0000 0000 0000 0000
*
01231f0 0000 0000 0000 0000 0000 0000 00d0 00d0
0123200 0000 0000 0000 0000 0000 0000 0000 0000
*
01233f0 0000 0000 0000 0000 0000 0000 0000 00d0
0123400 0000 0000 0000 0000 0000 0000 0000 0000
*

I will look into and fix the signal timings and adaptor circut...
-- 
Kristoffer Nyborg Gregertsen
MSc. student / Summer intern
Atmel Norway
