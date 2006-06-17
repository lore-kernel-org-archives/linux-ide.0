From: Mark Lord <mlord@pobox.com>
Subject: Re: regarding conversion to new EH
Date: Sat, 17 Jun 2006 10:34:37 -0400
Message-ID: <449412FD.8030102@pobox.com>
References: <20060617113104.GC11755@htj.dyndns.org> <4493EF61.9060103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proof.pobox.com ([207.106.133.28]:2979 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1751635AbWFQOel (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jun 2006 10:34:41 -0400
In-Reply-To: <4493EF61.9060103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff, sx4 seems to be a strain of promise controllers.  Can you
>> convert that one too in addition to sata_promise?
> 
> Yeah, I'll take a look at those.
> 
> 
>> I guess the two 'trying' conversions are probably broken.  Mark, it
>> would be great if you can verify them.  Also, can you please convert
>> sata_mv to new EH?
> 
> I'll see if I can find a PDC ADMA card, to verify.

I've still got a box full of the PATA ADMA cards here (Tejun: want a couple?),
so I'll test that as well, along with the sata_qstor, after the weekend.

Once I take time to see exactly how this new EH stuff works,
I'd love to convert sata_mv.  It's EH current EH works,
but it locks up the machine for a few seconds while doing things.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

