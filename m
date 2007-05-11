From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data xfer
 functions
Date: Fri, 11 May 2007 19:53:21 +0200
Message-ID: <4644AD91.3000600@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com>	<20070508134540.509f4704@the-village.bc.nu>	<464073B1.80303@gmail.com>	<4644192A.8090809@tw.ibm.com>	<46441CA9.4030109@tw.ibm.com>	<46447FB5.3040306@gmail.com>	<20070511155504.37e12a12@the-village.bc.nu>	<46448469.7070704@gmail.com>	<20070511161252.14b61207@the-village.bc.nu>	<4644885B.3050006@gmail.com>	<20070511163953.5060c670@the-village.bc.nu>	<4644A109.6010704@gmail.com> <20070511184651.0543d5ac@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:11600 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662AbXEKRyg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 13:54:36 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1083887nzf
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 10:54:35 -0700 (PDT)
In-Reply-To: <20070511184651.0543d5ac@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>>> Now if we are unlucky and the IRQ gets in between the last byte of
>>> transfer and clearing the active ignore IRQ flag we will still run the
>>> completion handler
>> I don't really get this.  What happens if the IRQ is shared and the
>> other device raises interrupt while the data transfer is still in
>> progress?  What prevents it from running the completion routine?
[--snip--]
> c) the IRQ beats the clearing of the ignore irq flag in which case it
> won't execute the handler but the data transfer path will

This case is where I fail to understand how it's supposed to work.  If
IRQ beats the clearing of the ignore irq flag && execution of completion
routine from wq, it ignores the IRQ, right?  The IRQ line remains
asserted, so when the IRQ handler finishes, it's entered again
immediately till nobody-cared kicks in and completely disable the IRQ
line.  ie.

	clear_bit(COMPLETION_RUN, ->flags);
	xfer bytes
	>> IRQ hits here
	if (test_and_set_bit(COMPLETION_RUN, ->flags) == 0)
		run_completion_routine();
	->active-ignore-irq = 0;

-- 
tejun
