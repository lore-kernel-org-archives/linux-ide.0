From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries
 CD drives
Date: Fri, 16 Feb 2007 17:55:08 +0300
Message-ID: <45D5C5CC.9070406@ru.mvista.com>
References: <20070210203512.GA25586@aepfle.de> <20070216092046.GA2572@aepfle.de> <45D5B720.4010308@ru.mvista.com> <200702161553.54550.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51155 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422638AbXBPOzS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Feb 2007 09:55:18 -0500
In-Reply-To: <200702161553.54550.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Olaf Hering <olaf@aepfle.de>, Jeff Garzik <jeff@garzik.org>, Paul Mackeras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>    I'm sorry, how those 2 drivers can be equivalent?! The pata_winbond driver 
>>is for VLB only, sl81c105 was for PCI only -- you certainly want to use 
>>pata_sl82c105 (indeed better version of sl82c105 driver).

> I was under the impression that with your fixes these drivers
> (sl82c105 and pata_sl82c105) are functionally equivalent.

    They're not yet equivalent. pata_sl82c105 supports all MWDMA modes, 
sl82c105 still supports only MWDMA2.

WBR, Sergei
