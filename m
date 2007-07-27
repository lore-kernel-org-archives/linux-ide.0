From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_cmd64x: Correct the speed ranges
Date: Fri, 27 Jul 2007 16:29:07 +0400
Message-ID: <46A9E513.70801@ru.mvista.com>
References: <200707262101.l6QL1Iqk029149@harpo.it.uu.se> <46A90F23.8010907@ru.mvista.com> <46A91AD8.40908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:45360 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932689AbXG0M1I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2007 08:27:08 -0400
In-Reply-To: <46A91AD8.40908@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Hello.

Jeff Garzik wrote:

>>    Note that the olde driver has MWDMA fixed, and the new one has it 
>> still borken, yet MWDMA2 is the mode you're using.

> What about MWDMA is broken?

    The code that "sets" MWDMA timings is completely bogus -- I've already 
reported that before. And now I've fixed this in the old IDE driver at last.

>     Jeff

MBR, Sergei
