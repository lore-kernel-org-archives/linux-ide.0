From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Fwd: [PATCH] siimage: PIO1/2 taskfile transfer overclocking fix
Date: Fri, 02 Feb 2007 22:46:35 +0100
Message-ID: <45C3B13B.5090009@gmail.com>
References: <200701282346.55935.sshtylyov@ru.mvista.com>	 <45BD0C23.8000004@ru.mvista.com> <58cb370e0702021327x8d7bb77uaf949ee91b26b14d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:26253 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946133AbXBBVln (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 16:41:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so879241uga
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 13:41:42 -0800 (PST)
In-Reply-To: <58cb370e0702021327x8d7bb77uaf949ee91b26b14d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk


Sergei Shtylyov wrote:
> 
> Hello, I wrote:
>> Fix two typos found by SiI680A documentation check.  They caused the taskfile
>> transfer overclocking:
>>
>> - in PIO mode 1 as 0x2283 must be used for both data and taskfile transfers;
>>
>> - in PIO mode 2 as data and taskfile timings are swapped when writing to the
>>   MMIO regs.
>>
>> Fix coding style and trailing whitespace in enclosing statements while at it...
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>    Forgot to specify that this patch was against Linus' tree...

applied

