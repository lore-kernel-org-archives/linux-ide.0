From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Sat, 01 Nov 2008 19:16:14 +0300
Message-ID: <490C80CE.4090505@ru.mvista.com>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <490A4156.5080302@ru.mvista.com> <20081031000912.GB10620@nuty> <490AE023.9040906@ru.mvista.com> <20081101160930.GA10321@nuty>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40174 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751656AbYKAQQT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Nov 2008 12:16:19 -0400
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP id CAB743EC9
	for <linux-ide@vger.kernel.org>; Sat,  1 Nov 2008 09:16:17 -0700 (PDT)
In-Reply-To: <20081101160930.GA10321@nuty>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello.

Phil Sutter wrote:

>>   No. The alternatives would be to use local variable as a loop counter 
>> or, better yet, using readsb()/writesb() instead of the loops...
>> Wait! The original driver used 32-bit I/O to this register, not 8-bit -- 
>> so it looks like you have artificially slowed it down... :-/
>>     
>
> Ok, so this should be clear now. I changed the code to use readl() and
> writel() (the reads*() and writes*() versions sadly aren't useable as
> they increment the target memory pointer) which worked fine.
>   

   So what? This is perfectly valid. Doesn't the current code increment it?

MBR, Sergei


