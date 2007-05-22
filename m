From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: [PATCH] ahci: disable 64bit dma on sb600
Date: Tue, 22 May 2007 16:59:09 +1000 (EST)
Message-ID: <232730.3937.qm@web52601.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52601.mail.re2.yahoo.com ([206.190.48.204]:29480 "HELO
	web52601.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758750AbXEVG7K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 May 2007 02:59:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: wolke.liu@amd.com, linux-ide@vger.kernel.org

> Tejun Heo <htejun@gmail.com> wrote:
> > SB600 claims it can do 64bit DMA but it can't.  Disable it.
[...]
> > Srihari, can you test this against 2.6.22-rc1-git7 just in case?  I'll
> > send this upstream after you ack.

It's merged in today's git (quickly tested it & it's working good as expected)
:-). Impressive.

Well done & thank you Tejun & others!

Thanks

PS: Time to find other bugs & bug other maintainers :-).



      ___________________________________________________________________________________
How would you spend $50,000 to create a more sustainable environment in Australia?  Go to Yahoo!7 Answers and share your idea.
http://advision.webevents.yahoo.com/aunz/lifestyle/answers/y7ans-babp_reg.html

