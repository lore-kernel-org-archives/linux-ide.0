From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] hpt366: add hpt3xx_disable_fast_irq() helper
Date: Thu, 16 Oct 2008 01:55:06 +0400
Message-ID: <48F666BA.9040104@ru.mvista.com>
References: <200808021915.03424.bzolnier@gmail.com> <48F50649.9080507@ru.mvista.com> <200810152011.18478.bzolnier@gmail.com> <48F65E48.8080301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:37184 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751839AbYJOVzL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 17:55:11 -0400
In-Reply-To: <48F65E48.8080301@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I just wrote:

>> Not such a big deal, we just have to make an another one...
>>
>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Subject: [PATCH] hpt366: fix compile warning
>>
>> Fixup for commit 1785192b5310ee25165768f5bb80f13146788e3e
>> ("hpt366: add hpt3xx_disable_fast_irq() helper"):
>>
>>    CC      drivers/ide/pci/hpt366.o
>> drivers/ide/pci/hpt366.c: In function `init_hwif_hpt366':
>> drivers/ide/pci/hpt366.c:1290: warning: unused variable `dev'
>>
>> Reported-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>   
>
>   Duh. I've posted this patch a bit earlier. ;-)

   No, you were the first, so just add my:

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


