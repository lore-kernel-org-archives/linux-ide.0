From: arvindY <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] pata_pdc2027x: Remove unnecessary error check and coding
 style error.
Date: Sat, 25 Nov 2017 15:49:33 +0530
Message-ID: <5A1943B5.2070304@gmail.com>
References: <9c2e4c1081be44da4460072ae6129d29c7e6d6bc.1511583254.git.arvind.yadav.cs@gmail.com>
 <4dcd6458-f289-57e0-a921-5e1b00d91800@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39094 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdKYKTh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 25 Nov 2017 05:19:37 -0500
In-Reply-To: <4dcd6458-f289-57e0-a921-5e1b00d91800@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Sergei,

On Saturday 25 November 2017 03:30 PM, Sergei Shtylyov wrote:
> On 11/25/2017 7:15 AM, Arvind Yadav wrote:
>
>> Here, The function pdc_hardware_init always return zero. So it is not
>> necessary to check its return value.
>>
>> Fix these checkpatch.pl error:
>>
>> ERROR: space prohibited after that '~' (ctx:WxW)
>> +        mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
>>
>> ERROR: spaces required around that '?' (ctx:VxW)
>> +    long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
>>
>> ERROR: that open brace { should be on the previous line
>> +    const struct ata_port_info *ppi[] =
>> +        { &pdc2027x_port_info[board_idx], NULL };
>>
>
>    Please fix the checkpatch.pl errors in a sperate patch.
Please find a patch v3, which does not include checkpatch.pl error fix.
>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> [...]
>
> MBR, Sergei
~arvind
