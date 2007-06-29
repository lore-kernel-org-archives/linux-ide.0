From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [1/2] 2.6.22-rc6: known regressions v2
Date: Fri, 29 Jun 2007 21:09:55 +0400
Message-ID: <46853CE3.3050907@ru.mvista.com>
References: <46852187.3080504@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:14821 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753185AbXF2RIN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 13:08:13 -0400
In-Reply-To: <46852187.3080504@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, David Chinner <dgc@sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Michal Piotrowski wrote:

> IDE

> Subject    : 2.6.22-rcX: hda: lost interrupt
> References : http://lkml.org/lkml/2007/6/29/121
> Submitter  : David Chinner <dgc@sgi.com>
> Status     : unknown

> Probing IDE interface ide0...
> hda: probing with STATUS(0xa0) instead of ALTSTATUS(0x58)

   Ugh, 0xa0 is the device/head register's value, not the status register's!
I'd suppose that I/O space was borken in some funny way, however, it would be 
hard top expect form x86 which should be prone to endiannes blues...

MBR, Sergei
