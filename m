From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata question
Date: Thu, 03 Aug 2006 00:02:49 +0900
Message-ID: <44D0BE99.8010809@gmail.com>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>	 <1154457583.4665.5.camel@shark.pacific>  <44CFA15C.8080109@gmail.com>	 <1154458981.4665.9.camel@shark.pacific>  <44CFA618.2090204@gmail.com>	 <1154502301.5691.23.camel@acme>  <44D0522E.6030905@gmail.com> <1154529340.25611.75.camel@acme>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:7223 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751157AbWHBPCh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Aug 2006 11:02:37 -0400
Received: by wx-out-0102.google.com with SMTP id s14so765048wxc
        for <linux-ide@vger.kernel.org>; Wed, 02 Aug 2006 08:02:36 -0700 (PDT)
In-Reply-To: <1154529340.25611.75.camel@acme>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Oberholtzer <roger@opq.se>
Cc: linux-ide@vger.kernel.org

Roger Oberholtzer wrote:
> Can the removal echo be done after the disk is physically removed? I
> expect not as this seems to confuse things. If this is the case, is
> there any way to restore sanity without a reboot?

It shouldn't require a reboot under any circumstances.  Without dmesg 
and explanation of what you did, I cannot help you much.  What do you 
mean by sanity?  What makes you think libata lost sanity?  *Please* be 
more specific.

-- 
tejun
