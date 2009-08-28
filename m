From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH #upstream] libata: enhance command parsing
Date: Fri, 28 Aug 2009 17:55:35 -0600
Message-ID: <4A986E77.9040000@gmail.com>
References: <4A72105F.40704@gmail.com> <4A8F88B2.6050900@gmail.com>	 <4A8FFA44.30604@rtr.ca> <51f3faa70908220936w309d9754p4f96cee44d58ea63@mail.gmail.com> <4A905A4E.5000309@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f200.google.com ([209.85.211.200]:38139 "EHLO
	mail-yw0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbZH2AAk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Aug 2009 20:00:40 -0400
Received: by ywh38 with SMTP id 38so3244781ywh.20
        for <linux-ide@vger.kernel.org>; Fri, 28 Aug 2009 17:00:42 -0700 (PDT)
In-Reply-To: <4A905A4E.5000309@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>

On 08/22/2009 02:51 PM, Mark Lord wrote:
>> Actually, I think the code+data size of this version is not much
>> different from the previous version. One might be able to come up with
>> a structure that you could encapsulate all the strings into and that
>> you could search through to find the right one, but it'd be tricky to
>> do that without making the structure end up containing a bunch of
>> padding and other wasted space that would add as much data size as you
>> saved in code size. Unless you have a great idea on the subject that
>> I'm not thinking of right after waking up :-)
> ..
>
> I've done lots of this type of thing in the past,
> putting the parsing knowledge into the data structure
> and reducing the code to nearly nothing (at the expense
> of more data than before).
>
> But right now I'm not offering to do it, so no objection
> from me to the current state. :)

Any other thoughts on this one? Jeff?
