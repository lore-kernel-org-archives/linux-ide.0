From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: no DRQ after issuing MULTWRITE_EXT ?
Date: Thu, 01 Feb 2007 19:06:06 +0300
Message-ID: <45C20FEE.5010904@ru.mvista.com>
References: <45C1B079.3080704@imc-berlin.de> <45C1E5CD.8010707@ru.mvista.com> <45C1EC18.5040802@imc-berlin.de> <45C1ED96.3030701@ru.mvista.com> <45C20F09.4070908@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:54733 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751839AbXBAQGL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 11:06:11 -0500
In-Reply-To: <45C20F09.4070908@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

Hello.

Steven Scholz wrote:

>>>>  Looks like a spurious interrupt... Is your IDE IRQ shared with other
>>>>devices?

>>>.. 
>>>But IIUC then first the HDD times out, the ide driver handles this and
>>>then an irq occurs which is probably the irq the driver was waiting for.

>>   The driver is *not* waiting for any IRQ after issuing MULTWRITE_EXT,
>>that's why it's "unexpected".

> Hmm. But how does he "know" when that MULTWRITE_EXT is finished!?

    It's considered finished in this case as there was no starting DRQ 
"handshake".  The first interrupt should happen only after the first block of 
data is written.

> Steven

MBR, Sergei
