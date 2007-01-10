From: Jeff Garzik <jeff@garzik.org>
Subject: Re: No DMA with HTP370 IDE controller
Date: Wed, 10 Jan 2007 12:28:08 -0500
Message-ID: <45A52228.1020803@garzik.org>
References: <45A29690.3040003@berlin.de>	 <58cb370e0701081155j7376d15dv32e3b65906c8d325@mail.gmail.com>	 <45A35A8C.9040200@berlin.de> <58cb370e0701090544p2a851182m30f24e0fdd86f328@mail.gmail.com> <45A435A3.2020506@berlin.de> <45A4DAED.9070404@ru.mvista.com> <45A51259.2020904@berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44486 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964994AbXAJR2M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jan 2007 12:28:12 -0500
In-Reply-To: <45A51259.2020904@berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Bueker <m.bueker@berlin.de>
Cc: linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Michael Bueker wrote:
> Sergei Shtylyov wrote:
>>    Then it's probably the same issue as here:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=7703
>>
>>    What's really strange is that my HPT370 is working fine.  However, 
>> the chip marking says it's HPT370A despite the revision ID is 3 (which 
>> should correspond to HPT370)...
> 
> Unfortunately, I'm unable to compile a 2.4.18 kernel (my gcc is probably
> too new) for testing.
> 
> But anyways - do you think there's hope for fixing this? If I can
> provide you with any more helpful information, please tell me.
> 
> My controller is:
> 
> http://www.michael-bueker.de/files/hpt370/

Does the libata driver work?

	Jeff



