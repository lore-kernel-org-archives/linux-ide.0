From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Fri, 26 Oct 2007 19:38:19 +0400
Message-ID: <472209EB.4020103@ru.mvista.com>
References: <200710142211.03382.marogge@onlinehome.de> <200710200109.58872.marogge@onlinehome.de> <471A36DC.4040509@ru.mvista.com> <200710212255.50123.marogge@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:58285 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752752AbXJZPiM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 11:38:12 -0400
In-Reply-To: <200710212255.50123.marogge@onlinehome.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Rogge <marogge@onlinehome.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Hello.

Martin Rogge wrote:

>>    What I don't like is that both PIIX4 and PCI-648 are sharing IRQ15
>>(PIIX4 is in legacy mode, so it uses edge-triggered IRQ15 which is not
>>shareable). You don't have drives connected to PIIX4, do you?  However, it
>>doesn't look like a glitch on IRQ15, it looks like MRDMODE reg. doesn't
>>work as documented...

> Well, don't worry too much about the PIIX device. I have disabled it in the 
> BIOS, and I haven't compiled the driver into the kernel.

    You can't disable IRQ14/15 it uses this way.

> MOst likely you're on the right track with the mrdmode register.

    Yet I want to make sure the manual is lying...

> cu Martin

MBR, Sergei
