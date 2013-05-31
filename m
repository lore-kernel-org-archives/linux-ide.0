From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] ata: increase retry count but shorten duration for
 Calxeda controller
Date: Fri, 31 May 2013 17:13:57 +0400
Message-ID: <51A8A215.2030706@cogentembedded.com>
References: <1369923509-3246-1-git-send-email-mark.langsdorf@calxeda.com> <51A76197.9080708@calxeda.com> <51A7646B.6080203@cogentembedded.com> <51A848F1.3040301@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:55318 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab3EaNNy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 May 2013 09:13:54 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so1671775lbi.37
        for <linux-ide@vger.kernel.org>; Fri, 31 May 2013 06:13:53 -0700 (PDT)
In-Reply-To: <51A848F1.3040301@ladisch.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Timur Tabi <timur.tabi@calxeda.com>, Mark Langsdorf <mark.langsdorf@calxeda.com>, tj@kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

On 31-05-2013 10:53, Clemens Ladisch wrote:

>>>> +    const unsigned long timing[] = { 5, 100, 500};

>>> You'll save space and time if you also make this array "static",
>>> otherwise the compiler will build the array every time this function is
>>> called.

>> No, *const* specifier is enough to not build this array every time. It will be put into the .const section.

> gcc disagrees:

> $ cat const_static.c
> int f(int x) {
> 	const unsigned long timing[] = { 5, 100, 500};
> 	static const unsigned long timing2[] = { 5, 100, 500};
> 	return timing[x] + timing2[x];
> }
> $ gcc -Os -S const_static.c
> $ cat const_static.s
	...
> timing2.0:
>          .long   5
>          .long   100
>          .long   500
> 	...
>          movl    8(%ebp), %edx
>          movl    $5, -16(%ebp)
>          movl    $100, -12(%ebp)
>          movl    $500, -8(%ebp)
>          movl    timing2.0(,%edx,4), %eax
>          addl    -16(%ebp,%edx,4), %eax

    Hm, I remember I was convinced by somebody just *const* was enough 
for the data to be put to .const section. Don't remember if he gave an 
object code example... Well, it means that person was wrong. Mark, we 
then need *static* as well...

> Regards,
> Clemens

WBR, Sergei

