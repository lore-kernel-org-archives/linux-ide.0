From: Tejun Heo <htejun@gmail.com>
Subject: Re: regarding conversion to new EH
Date: Sun, 18 Jun 2006 11:33:03 +0900
Message-ID: <4494BB5F.6030108@gmail.com>
References: <20060617113104.GC11755@htj.dyndns.org> <4493EF61.9060103@pobox.com> <449412FD.8030102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:33732 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932067AbWFRCdF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 22:33:05 -0400
Received: by py-out-1112.google.com with SMTP id i49so957795pye
        for <linux-ide@vger.kernel.org>; Sat, 17 Jun 2006 19:33:04 -0700 (PDT)
In-Reply-To: <449412FD.8030102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
>> I'll see if I can find a PDC ADMA card, to verify.
> 
> I've still got a box full of the PATA ADMA cards here (Tejun: want a 
> couple?),

That would be great.  I'll mail you my address in private mail.

> so I'll test that as well, along with the sata_qstor, after the weekend.
> 
> Once I take time to see exactly how this new EH stuff works,
> I'd love to convert sata_mv.  It's EH current EH works,
> but it locks up the machine for a few seconds while doing things.

Great.  As Alan is converting PATA drivers, it seems that we'll be able 
to kill old EH pretty soon.

Thanks.

-- 
tejun
