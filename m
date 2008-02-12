From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream] libata: implement libata.force module parameter
Date: Tue, 12 Feb 2008 09:24:12 +0900
Message-ID: <47B0E72C.3050305@gmail.com>
References: <47A3375F.80101@gmail.com> <47A356C3.3010904@garzik.org> <20080201183621.GC14759@uranus.ravnborg.org> <47ABD817.2020903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:9822 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYBLAYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 19:24:19 -0500
Received: by el-out-1112.google.com with SMTP id v27so1870448ele.23
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 16:24:19 -0800 (PST)
In-Reply-To: <47ABD817.2020903@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> Sam Ravnborg wrote:
>> I have lost the actual patch.
>> But what you see is what happens when you mix const and non-const data
>> in the same section.
>>
>> Look for use of __initdata for const data and replace it with __initconst.
>>
>> And modpost cannot warn about it as gcc errors out before we look at the
>> .o file with modpost.
> 
> OIC, thanks.  Hmmm... in init.h, I see __{dev|cpu|mem}initconst but no
> __initconst.  The data structure in question is used from module init
> function tagged properly with __init.  What should be done here?

PING.

-- 
tejun
