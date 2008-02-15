From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk,
 take #3
Date: Fri, 15 Feb 2008 12:16:48 +0900
Message-ID: <47B50420.3060403@gmail.com>
References: <12028937731333-git-send-email-htejun@gmail.com>	<20080213155701.48871761.akpm@linux-foundation.org>	<47B38E13.1060503@gmail.com>	<20080213170950.86945835.akpm@linux-foundation.org>	<47B398B3.40308@gmail.com>	<47B4EFAB.2040102@gmail.com>	<20080214182700.a9a706e9.akpm@linux-foundation.org>	<47B4FA9C.9080809@gmail.com> <20080214185003.9ca9a640.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:40032 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbYBODQ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 22:16:56 -0500
Received: by rv-out-0910.google.com with SMTP id k20so380538rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 19:16:55 -0800 (PST)
In-Reply-To: <20080214185003.9ca9a640.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jengelh@computergmbh.de, matthew@wil.cx, randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> So, I guess it's NACK w/o suggested alternatives, right?
> 
> I wouldn't nack without good reasons, and I have none here.  I don't have
> very strong opinions either way.

I was just wondering whether I should just go with snprintf dancing in
eh_link_report, which does make sense if not many need merging printk.

> As a seat-of-the-pants thing, it does seem to be a lot of core code to
> solve a fairly minor problem in (afaik) one remote place.  But I haven't
> looked - perhaps there are other places which could be improved if such
> facilities were available.

Okay, I see.  I'll look around and see whether there are other places
which can use it.  I can think of a few in SCSI.  Let's see.

Thanks.

-- 
tejun
