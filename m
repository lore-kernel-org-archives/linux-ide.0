From: Tejun Heo <htejun@gmail.com>
Subject: Re: Stardom SATA HSM violation
Date: Thu, 27 Sep 2007 16:05:30 +0900
Message-ID: <46FB563A.80108@gmail.com>
References: <46CFA08E.6090604@arbores.ca>	<6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com>	<46DBCB6C.8080206@gmail.com> <20070905095327.6277d054.akpm@linux-foundation.org> <46DEE617.4050004@rtr.ca> <46E0A253.7060803@gmail.com> <46E154DE.2060602@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:46337 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263AbXI0SQn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 14:16:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3255631wah
        for <linux-ide@vger.kernel.org>; Thu, 27 Sep 2007 11:16:43 -0700 (PDT)
In-Reply-To: <46E154DE.2060602@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, michal.k.k.piotrowski@gmail.com, bryan@arbores.ca, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> Tejun Heo wrote:
>> Hello,
>>
>> Mark Lord wrote:
>>> I reported a very similar bug back a few releases ago.
>>> Anyone who wants to try it themselves, can do this with hdparm-7.7 (from
>>> sourceforge):
>>>
>>>    hdparm --drq-hsm-error /dev/sda
>>>
>>> Whether or not it hangs the machine does depend upon exactly which SATA
>>> LLD is used,
>>> and what model/revision of drive is installed.  But if it hangs for you
>>> (eg. Tejun),
>>> then you now have a way to reproduce a HSM error "on demand" for
>>> testing.  :)
>>
>> Neat.  Is this the FIFO-draining issue?
> 
> Yeah, that's the one.  And I still patch my own kernels to
> automatically drain up to 512 words from the FIFO when this happens.
> 
> Works like a charm.  Patch below for demonstration purposes.
> 
> Signed-Off-By:  Mark Lord <mlord@pobox.com>

I think there have been enough cases where this draining was necessary.
 IIRC, ata_piix was involved in those cases, right?  If so, can you
please submit a patch which applies this only to affected controllers?
I don't feel too confident about applying this to all SFF controllers.

Thanks.

-- 
tejun

