From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk,
 take #3
Date: Fri, 15 Feb 2008 11:36:12 +0900
Message-ID: <47B4FA9C.9080809@gmail.com>
References: <12028937731333-git-send-email-htejun@gmail.com>	<20080213155701.48871761.akpm@linux-foundation.org>	<47B38E13.1060503@gmail.com>	<20080213170950.86945835.akpm@linux-foundation.org>	<47B398B3.40308@gmail.com>	<47B4EFAB.2040102@gmail.com> <20080214182700.a9a706e9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:45624 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764072AbYBOCgW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 21:36:22 -0500
Received: by wx-out-0506.google.com with SMTP id h31so513079wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 18:36:20 -0800 (PST)
In-Reply-To: <20080214182700.a9a706e9.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jengelh@computergmbh.de, matthew@wil.cx, randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>> printk is a special case, I think.  It's the primary logging/debugging
>>> method which can't fail and as it's mostly interpreted by human beings
>>> (and developers in problematic cases), it has different maneuvering room
>>> on errors - ie. it's far better to print messages w/o header or proper
>>> log level than failing to print, which is quite different requirements
>>> from other components.
>> Andrew, any more comments or suggestions on how to proceed on this?
> 
> Nope.
> 
>>  One
>> way or the other, I think this is a problem worth solving.
> 
> There are a lot of such problems ;)

So, I guess it's NACK w/o suggested alternatives, right?

-- 
tejun
