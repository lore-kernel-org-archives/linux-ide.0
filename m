From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] current libata eh doc
Date: Wed, 07 Sep 2005 07:55:11 -0400
Message-ID: <431ED51F.2020201@pobox.com>
References: <20050828024025.GA10501@htj.dyndns.org> <431EA20C.7000108@pobox.com> <431ED180.4060507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:16365 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751187AbVIGLzR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 07:55:17 -0400
In-Reply-To: <431ED180.4060507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> I would note that ->complete_fn() is the asynchronous path, and 
>> qc->waiting is the synchronous (sleeping in process context) path.

>  Okay.  One question though.  Is it necessary to keep these two 
> separate?  qc->waiting can easily be implemented in terms of 
> ->complete_fn() if we add a void *udata argument to it.  Is there any 
> design consideration I'm not aware of?


Synchronous usage (use of qc->waiting) is common and growing more 
common, so it seemed expedient to put 'waiting' in the data structure. 
I also thought it might be nice to have the completion occur after the 
->complete_fn() callback and tag poisoning occurred.

Certainly qc->waiting can be implemented in terms of ->complete_fn(). 
But unless unseen elegance (or bug fixes) will result, I'm not terribly 
inclined to change it.

	Jeff



