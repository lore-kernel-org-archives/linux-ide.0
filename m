From: linux@horizon.com
Subject: Re: sata_sil24 AMD64 crash/lockup
Date: 6 Oct 2005 15:10:00 -0400
Message-ID: <20051006191000.4625.qmail@science.horizon.com>
References: <4344CC61.8070609@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:39239 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751310AbVJFTKQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Oct 2005 15:10:16 -0400
In-Reply-To: <4344CC61.8070609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux@horizon.com, linux-ide@vger.kernel.org

>  Damn. I'm really late. :-)

Well, thank you for taking the trouble to reply!


>  However, your kernel hitting that path means that some drives are 
> actually generating errors.  Let's see about that after get tf_read 
> thing fixed.

Given that I'm reading about 2e+14 bits/day, and it takes a couple of
days to reproduce the error, the occasional glitch is not too surprising.

Thanks for the patches; I'm trying to see if I can get them by git
right now, but they appear to not be on kernel.org yet, so I guess
I'll have to try by hand.

Results in a bit!
