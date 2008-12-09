From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstream-fixes 1/3] pata_hpt366: fix cable detection,
Date: Tue, 09 Dec 2008 21:50:33 +0300
Message-ID: <493EBDF9.30107@ru.mvista.com>
References: <493E289F.1010000@kernel.org> <493E2926.4050509@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5043 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755102AbYLISuh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2008 13:50:37 -0500
In-Reply-To: <493E2926.4050509@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Hello.

Tejun Heo wrote:

>>pata_hpt366 is strange in that its two channels occupy two PCI
>>functions and both are primary channels and bit1 of PCI configuration
>>register 0x5A indicates cable for both channels.

>>Signed-off-by: Tejun Heo <tj@kernel.org>
>>Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>>Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> I tested this patch for all four combinations of 40/80c cables and it
> always worked correctly.

    So that means that the datasheet is wrong. May well be...

> Thanks.

MBR, Sergei
