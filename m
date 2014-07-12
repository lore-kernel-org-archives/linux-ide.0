From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3] libata: support the ata host which implements a queue
 depth less than 32
Date: Sat, 12 Jul 2014 04:36:43 +0400
Message-ID: <53C0831B.70504@cogentembedded.com>
References: <1405059026-18673-1-git-send-email-haokexin@gmail.com> <53BFD10D.3080005@cogentembedded.com> <20140712002626.GA314@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:54127 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbaGLAgc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 20:36:32 -0400
Received: by mail-la0-f42.google.com with SMTP id pn19so1444059lab.29
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 17:36:30 -0700 (PDT)
In-Reply-To: <20140712002626.GA314@pek-khao-d1.corp.ad.wrs.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

On 07/12/2014 04:26 AM, Kevin Hao wrote:

>>> -	for (i = 0; i < ATA_MAX_QUEUE; i++) {
>>> -		tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
>>> +	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
>>> +		tag = tag < max_queue ? tag : 0;

>>     Assigning 'tag' back to 'tag' is quite stupid, don't you think? Why not:

>> 		if (tag >= max_queue)
>> 			tag = 0;

> Since I am an idiot, it is very possible for me to write stupid code.
> But I don't believe this is one. I don't think the above code is more readable.

    Perhaps I'm an idiot (I even seldom doubt it) but to me it looks like 
clear abuse of the ?: operator. But that's probably just me...

> Thanks,
> Kevin

MBR, Sergei

