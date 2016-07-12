From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ide: hpt366: fix incorrect mask when checking at
 cmd_high_time
Date: Tue, 12 Jul 2016 14:09:51 +0300
Message-ID: <80ace01e-b03e-39f8-a6fe-ad2f61079731@cogentembedded.com>
References: <1468321179-7647-1-git-send-email-colin.king@canonical.com>
 <034d8edb-439e-eafe-0743-4b69bf50b49e@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <034d8edb-439e-eafe-0743-4b69bf50b49e@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, "David S . Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 7/12/2016 2:04 PM, Sergei Shtylyov wrote:

>> From: Colin Ian King <colin.king@canonical.com>
>>
>> According to the HPT366 data sheet, PCI config space dword 0x40-0x43
>> bits 11:8 specify the primary drive cmd_high_time, however,
>> currently just 3 bits of the 4 are being used because the mask
>> is 0x07 and not 0x0f.  Fix the mask, allowing for the 40MHz clock
>> to be detected.
>>
>> Also add in missing space between switch and parenthesis to clean
>> up a checkpatch warning.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    BTW, drivers/ata/pata_hpt366.c has the same bug...

MBR, Sergei
