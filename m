From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 12:54:21 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4067114D.7050606@pobox.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328173623.GA1087@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27861 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262130AbUC1Rye
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 12:54:34 -0500
In-Reply-To: <20040328173623.GA1087@mail.shareable.org>
List-Id: linux-ide@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jamie Lokier wrote:
> This is what I mean: turn off write cacheing, and performance on PATA
> drops because of the serialisation and lost inter-command time.
> 
> With TCQ-on-write, you can turn off write cacheing and in theory
> performance doesn't have to drop, is that right?

hmmm, that's a good point.  I honestly don't know.  Something to be 
tested, I suppose...

My premature guess would be that you would need a queue depth larger 
than 2 or 4 before performance starts to not-suck.

	Jeff



