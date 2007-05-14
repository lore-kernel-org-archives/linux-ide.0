From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data xfer
 functions
Date: Mon, 14 May 2007 10:24:11 +0200
Message-ID: <46481CAB.50405@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com>	<20070508134540.509f4704@the-village.bc.nu>	<464073B1.80303@gmail.com>	<4644192A.8090809@tw.ibm.com>	<46441CA9.4030109@tw.ibm.com>	<46447FB5.3040306@gmail.com>	<20070511155504.37e12a12@the-village.bc.nu>	<46448469.7070704@gmail.com>	<20070511161252.14b61207@the-village.bc.nu>	<4644885B.3050006@gmail.com>	<20070511163953.5060c670@the-village.bc.nu>	<4644A109.6010704@gmail.com>	<20070511184651.0543d5ac@the-village.bc.nu>	<4644AD91.3000600@gmail.com> <20070511230017.5905b10b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:15861 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759887AbXENIYZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 04:24:25 -0400
Received: by py-out-1112.google.com with SMTP id a29so1427740pyi
        for <linux-ide@vger.kernel.org>; Mon, 14 May 2007 01:24:24 -0700 (PDT)
In-Reply-To: <20070511230017.5905b10b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>> This case is where I fail to understand how it's supposed to work.  If
>> IRQ beats the clearing of the ignore irq flag && execution of completion
>> routine from wq, it ignores the IRQ, right?  The IRQ line remains
> 
> I was assuming your polling handler would be polling and clearing the IRQ
> status otherwise it doens't work anyway - cable noise or drive error and
> an early DRQ de-assert would do the same thing during a transfer with IRQ
> blocked only on the last dword.

Yeah, it's not a water-tight solution.  I don't think we can do that
with IRQ enabled during transfer.  So, we can have either highly jerky
but reliable system if PIO is used or usually better behaving PIO with
some chance of getting nobody-cared.  Also, we can flag known buggy
devices/controllers such that IRQ is disabled over PIO by default.  I
think it's worth doing but this definitely should be debated better.

-- 
tejun
