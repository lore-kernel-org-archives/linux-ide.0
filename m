From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fwd: Re: libata pmp support
Date: Mon, 27 Aug 2007 10:32:33 +0900
Message-ID: <46D229B1.4070409@gmail.com>
References: <200708241951.45684.iweksler@bezeqint.net> <46CF8F20.5040107@gmail.com> <200708261836.56416.iweksler@bezeqint.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:40506 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbXH0Bck (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Aug 2007 21:32:40 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1879140wah
        for <linux-ide@vger.kernel.org>; Sun, 26 Aug 2007 18:32:40 -0700 (PDT)
In-Reply-To: <200708261836.56416.iweksler@bezeqint.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: iweksler@bezeqint.net
Cc: linux-ide@vger.kernel.org

Izik Weksler wrote:
> 
>  >>>On Saturday 25 August 2007, Tejun Heo wrote:
>> Izik Weksler wrote:
>>> ----------  Forwarded Message  ----------
>>>
>>> Subject: Re: libata pmp support
>>> Date: Thursday 23 August 2007
>>> From: Izik Weksler <iweksler@bezeqint.net>
>>> To: Tejun Heo <htejun@gmail.com>
>>>
>>>  >>>On Thursday 23 August 2007, you wrote:
>>>> Izik Weksler wrote:
>>>>> Tejun,
>>>>>
>>>>> If you're sending the patch please send it to this address.
>>>> Okay, please test the attached patch and please cc
>>>> linux-ide@vger.kernel.org when replying.  Thanks.
>>> Tejun,
>>>
>>> The patch failed. It sais:
>> Against which version?  The patch will apply to 2.6.22.5 & 2.6.23-rcX
>> w/o the PMP patches.
> 
> Yeah. I realized that it applies to a version that doesn't contain pmp 
> support. I tried to apply it to the 2.6.22.2-3 that goes with the SUSE 10.3 
> and of course it failed because it is pmp patched.
> So you suggest that I use the 2.6.22.5 vanilla from the www.kernel.org? If not 
> please send me a link to the applicable version.

Yeap, please apply against vanilla kernels.  Thanks.

-- 
tejun
