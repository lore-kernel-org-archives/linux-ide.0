From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 08/11] add hotplug support, take 2
Date: Sat, 13 May 2006 21:56:59 +0900
Message-ID: <4465D79B.6080404@gmail.com>
References: <11473615261297-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:6063 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932416AbWEMM5H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 08:57:07 -0400
Received: by wr-out-0506.google.com with SMTP id i32so533653wra
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 05:57:06 -0700 (PDT)
In-Reply-To: <11473615261297-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hi.
> 
> This is part of patchset series described in [T].
> 
> This is the second take of add-hotplug-support patchset.  Changes from
> the last take[L] are
> 

One problem found here.  On hotplugs where power is applied at the same 
time, prereset() doesn't wait enough and the first reset often fails 
causing unnecessary delays.  I have fixed this in my repository by 
debouncing for 5 secs in prereset before probing resets.

-- 
tejun
