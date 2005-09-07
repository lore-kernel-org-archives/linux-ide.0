From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC] current libata eh doc
Date: Wed, 07 Sep 2005 21:21:37 +0900
Message-ID: <431EDB51.1040300@gmail.com>
References: <20050828024025.GA10501@htj.dyndns.org> <431EA20C.7000108@pobox.com> <431ED180.4060507@gmail.com> <431ED51F.2020201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:28972 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751208AbVIGMVq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 08:21:46 -0400
Received: by zproxy.gmail.com with SMTP id 13so1169436nzn
        for <linux-ide@vger.kernel.org>; Wed, 07 Sep 2005 05:21:43 -0700 (PDT)
In-Reply-To: <431ED51F.2020201@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Jeff Garzik wrote:
>>
>>> I would note that ->complete_fn() is the asynchronous path, and 
>>> qc->waiting is the synchronous (sleeping in process context) path.
> 
> 
>>  Okay.  One question though.  Is it necessary to keep these two 
>> separate?  qc->waiting can easily be implemented in terms of 
>> ->complete_fn() if we add a void *udata argument to it.  Is there any 
>> design consideration I'm not aware of?
> 
> 
> 
> Synchronous usage (use of qc->waiting) is common and growing more 
> common, so it seemed expedient to put 'waiting' in the data structure. I 
> also thought it might be nice to have the completion occur after the 
> ->complete_fn() callback and tag poisoning occurred.
> 
> Certainly qc->waiting can be implemented in terms of ->complete_fn(). 
> But unless unseen elegance (or bug fixes) will result, I'm not terribly 
> inclined to change it.
> 

  The problem with qc->waiting is that it currently doesn't have anyway 
to pass command result when waking up the issuer.  We currently do this 
by reading ATA registers from the issuer after being woken up.  This is 
fine for EH, but, for multi-qc translation, this can be done but is a 
bit cumbersome.

  Also, we're gonna need to pass more information when a command fails 
if advanced EH is implemented.  We can add an extra per-qc/device error 
descriptor to be used by synchrnous completion, but these can be done 
much elegantly with ->complete_fn() w/ an opaqueue pointer.

-- 
tejun
