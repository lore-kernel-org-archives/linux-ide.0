From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add human-readable error value decoding
Date: Fri, 11 May 2007 19:11:09 +0200
Message-ID: <4644A3AD.7000700@gmail.com>
References: <46428103.3040003@shaw.ca> <4642E92D.5010509@gmail.com> <4643AAF6.7080204@shaw.ca> <46449E59.90608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:51560 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384AbXEKRMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 13:12:31 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1070329nzf
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 10:12:31 -0700 (PDT)
In-Reply-To: <46449E59.90608@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>

Chuck Ebbert wrote:
> Robert Hancock wrote:
>>>> +          ehc->i.serror & SERR_TRANS_ST_ERROR ? "TransStatTransErr "
>>>> : "",
>>>> +          ehc->i.serror & SERR_UNRECOG_FIS ? "UnrecogFIS " : "",
>>>> +          ehc->i.serror & SERR_DEV_XCHG ? "DevExchanged " : "" );
>>> I'm not really convinced whether this is necessary.  The human readable
>>> form is also a bit cryptic and can get quite long.  So, mild NACK from
>>> me.
>>>
>> It certainly seems useful when debugging hotplug issues or random SATA
>> problems which end up being caused by communication problems. Without
>> this output, Joe User stands no chance of figuring out what's going on,
>> and neither does Joe libata Developer unless they really care to dig
>> through the spec and count bits to figure out what they mean. At least
>> with this you can see that there was a CRC error, etc. and go from that..
>>
> 
> Why not just document the error messages?
> 
> And the scsi ones too, I can't seem to find what the sense codes mean.

They are well documented elsewhere - the standard documents.  For sense
codes, t10.org.  For SError bits, t13.org.  You can get drafts free of
charge.

-- 
tejun
