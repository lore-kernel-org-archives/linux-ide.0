From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: regarding conversion to new EH
Date: Sat, 17 Jun 2006 08:02:41 -0400
Message-ID: <4493EF61.9060103@pobox.com>
References: <20060617113104.GC11755@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12749 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751523AbWFQMCs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jun 2006 08:02:48 -0400
In-Reply-To: <20060617113104.GC11755@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff, sx4 seems to be a strain of promise controllers.  Can you
> convert that one too in addition to sata_promise?

Yeah, I'll take a look at those.


> I guess the two 'trying' conversions are probably broken.  Mark, it
> would be great if you can verify them.  Also, can you please convert
> sata_mv to new EH?

I'll see if I can find a PDC ADMA card, to verify.

	Jeff



