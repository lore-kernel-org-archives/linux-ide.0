From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2] IDE: Fix platform device registration in Swarm IDE
 driver
Date: Mon, 29 Sep 2008 12:00:14 +0400
Message-ID: <48E08B0E.9010504@ru.mvista.com>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com> <20080928113931.GA9207@linux-mips.org> <20080928175450.GA8478@linux-mips.org> <48DFFC62.9050300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25250 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751584AbYI2IAZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 04:00:25 -0400
In-Reply-To: <48DFFC62.9050300@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

Hello, I wrote:

>> The Swarm IDE driver uses a release method which is defined in the 
>> driver
>> itself thus potentially oopsable.  The simple fix would be to just leak
>> the device but this patch goes the full length and moves the entire
>> handling of the platform device in the platform code and retains only
>> the platform driver code in drivers/ide/mips/swarm.c.
>>
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>   
>
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

   Perhaps worth splitting into arch/mips/ and the follow-up 
drivers/ide/ patches though...

MBR, Sergei


