From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] ata: increase retry count but shorten duration for
 Calxeda controller
Date: Thu, 30 May 2013 18:38:35 +0400
Message-ID: <51A7646B.6080203@cogentembedded.com>
References: <1369923509-3246-1-git-send-email-mark.langsdorf@calxeda.com> <51A76197.9080708@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:59181 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932636Ab3E3Oif (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 May 2013 10:38:35 -0400
Received: by mail-lb0-f181.google.com with SMTP id w20so622728lbh.26
        for <linux-ide@vger.kernel.org>; Thu, 30 May 2013 07:38:33 -0700 (PDT)
In-Reply-To: <51A76197.9080708@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timur Tabi <timur.tabi@calxeda.com>
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, tj@kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

On 30-05-2013 18:26, Timur Tabi wrote:

>> -	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
>> +	const unsigned long timing[] = { 5, 100, 500};

> You'll save space and time if you also make this array "static",
> otherwise the compiler will build the array every time this function is
> called.

    No, *const* specifier is enough to not build this array every time. 
It will be put into the .const section.

WBR, Sergei

