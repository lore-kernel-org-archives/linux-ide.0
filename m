From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 08 May 2007 14:01:40 +0200
Message-ID: <464066A4.1010008@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com> <20070508130025.7693980c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:30316 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967423AbXEHMBx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 08:01:53 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1935643nzf
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 05:01:53 -0700 (PDT)
In-Reply-To: <20070508130025.7693980c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
> On Tue, 08 May 2007 19:30:24 +0800
> Albert Lee <albertcc@tw.ibm.com> wrote:
> 
>> Problem:
>>   Kernel got "irq 5: nobody cared" when using
>>   libata + polling IDENTIFY + Promise 20275 adapter + Benq DW1620 drive.
>>
>>   Detail message available in bug 8441 (http://bugzilla.kernel.org/show_bug.cgi?id=8441).
>>
>> Cause:
>>   The Benq DW1620 drive raises INTRQ during polling IDENTIFY PACKET DEVICE, 
>>   even if nIEN = 1.
>>
>> Proposed fix:
>>   Ack the possibly unexpected irq in ata_interrupt().
>>
>> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> NAK
> 
> We can't do this. A PIO data transfer could take far far too long to be
> under IRQ block (its already a problem on a big 32bit box when we bounce
> buffer it sometimes).

Oh well, that's how we do PIO data transfer when not polling anyway.  We
kick HSM directly from the interrupt handler and do PIO inside the
interrupt handler.  The change made here is to make polling PIO act the
same way.

-- 
tejun
