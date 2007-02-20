From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: add/fix enablebits
Date: Tue, 20 Feb 2007 17:28:35 +0300
Message-ID: <45DB0593.8060500@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702150135.28934.sshtylyov@ru.mvista.com> <200702200009.38168.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:8804 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S964928AbXBTO2p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 09:28:45 -0500
In-Reply-To: <200702200009.38168.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>The IDE core looks at the wrong bit when checking if the secondary channel is
>>enabled on PCI0646 -- CFR bit 8 is read-ahead disable, bit 3 is the correct one.

> I guess that you meant CNTRL here?

    Yeah, and bit 7. :-<

> [ I corrected this in the applied patch ]

>>Starting with PCI0646U chip, the primary channel can also be enbled/disabled --
>>so, add 'enablebits' initializers to each 'ide_pci_device_t' structure, handling
>>the original PCI0646 via adding the init_setup() method and clearing the 'reg'
>>field there if necessary...
>>
>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

    Thanks!

MBR, Sergei
