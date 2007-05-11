From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data xfer
 functions
Date: Fri, 11 May 2007 16:57:45 +0200
Message-ID: <46448469.7070704@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com>	<20070508134540.509f4704@the-village.bc.nu>	<464073B1.80303@gmail.com>	<4644192A.8090809@tw.ibm.com>	<46441CA9.4030109@tw.ibm.com>	<46447FB5.3040306@gmail.com> <20070511155504.37e12a12@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:23554 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbXEKO6H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 10:58:07 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1066440wra
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 07:58:06 -0700 (PDT)
In-Reply-To: <20070511155504.37e12a12@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>> Aieee, we have to transfer the whole last sector while holding the spin
>> lock and IRQ disabled.  That's sad but pushing locking into ->data_xfer
>> doesn't sound attractive either.  Any better ideas?
> 
> I'd say this is a non-starter. It solves nothing and means PIO in libata
> is still basically unusable.

It doesn't solve the problem completely but still helps, FWIW.  I was
hoping we could lock only for the last transfer (word).  Would it
complicate ->data_xfer() too much?

-- 
tejun
