From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/9] pdc202xx_old: implement test_irq() method
Date: Fri, 12 Jun 2009 23:31:33 +0400
Message-ID: <4A32AD15.40801@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906102301.09022.sshtylyov@ru.mvista.com> <200906121820.19163.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34230 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755935AbZFLTbh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jun 2009 15:31:37 -0400
In-Reply-To: <200906121820.19163.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>> Implement test_irq() method based on the driver's former dma_test_irq() method.
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>
>> ---
>> The patch is atop of ide-2.6.git 'for-next' branch.
>> Bart, it wouldn't hurt to check this against the documentation...
>>     
>
> no luck with the docs again, they list all those bits as reserved..
>   

  Ugh, I wonder where the author got the info then -- the bits were 
quite well described...

MBR, Sergei


