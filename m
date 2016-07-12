From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ide: hpt366: fix incorrect mask when checking at
 cmd_high_time
Date: Tue, 12 Jul 2016 14:16:29 +0300
Message-ID: <3ced7a51-bca9-5814-080c-350ca320a036@cogentembedded.com>
References: <1468321179-7647-1-git-send-email-colin.king@canonical.com>
 <034d8edb-439e-eafe-0743-4b69bf50b49e@cogentembedded.com>
 <80ace01e-b03e-39f8-a6fe-ad2f61079731@cogentembedded.com>
 <5784D01D.7070304@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35248 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbcGLLQc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 07:16:32 -0400
Received: by mail-lf0-f53.google.com with SMTP id f93so10092060lfi.2
        for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2016 04:16:31 -0700 (PDT)
In-Reply-To: <5784D01D.7070304@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>, "David S . Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On 7/12/2016 2:10 PM, Colin Ian King wrote:

>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> According to the HPT366 data sheet, PCI config space dword 0x40-0x43
>>>> bits 11:8 specify the primary drive cmd_high_time, however,
>>>> currently just 3 bits of the 4 are being used because the mask
>>>> is 0x07 and not 0x0f.  Fix the mask, allowing for the 40MHz clock
>>>> to be detected.
>>>>
>>>> Also add in missing space between switch and parenthesis to clean
>>>> up a checkpatch warning.
>>>>
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>
>>> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>>    BTW, drivers/ata/pata_hpt366.c has the same bug...
>
> OK, I'll fix that too in a moment.

    TIA! Don't forget to increment the version though. :-)

MBR, Sergei

