From: Jeff Garzik <jeff@garzik.org>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 08:14:01 -0500
Message-ID: <49689F19.7030203@garzik.org>
References: <200901091334.55823.borntraeger@de.ibm.com> <49688B63.5030105@ru.mvista.com> <20090110122130.318cf168@lxorguk.ukuu.org.uk> <200901101404.39139.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38084 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbZAJNOS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jan 2009 08:14:18 -0500
In-Reply-To: <200901101404.39139.borntraeger@de.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

Christian Borntraeger wrote:
> Am Samstag 10 Januar 2009 schrieb Alan Cox:
>>>    That's the typical REQUEST SENSE command with 18-byte data length.
>> Which means something has become horribly broken in the core libata stack.
>> An 18 byte inquiry would have 18 bytes as the *last* sg element. That
>> would therefore not trigger the WARN_ON. Someone has passed an sg list
>> that isn't properly terminated perhaps ?
>>
>> I wonder if the pad code broke this.
> 
> I just checked 2.6.28 + PIO32 patch. Its also broken. Whatever caused this 
> problem did it a while ago.

Just to be clear, you mean:

2.6.28 is OK
2.6.28 + PIO32 is broken

Correct?

	Jeff




