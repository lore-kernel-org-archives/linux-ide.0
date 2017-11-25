From: arvindY <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] pata_pdc2027x: Fix coding sytle error
Date: Sat, 25 Nov 2017 16:40:14 +0530
Message-ID: <5A194F96.2020605@gmail.com>
References: <68e25992911d7c4d6c17b9f31524a614466d9588.1511605703.git.arvind.yadav.cs@gmail.com>
 <1511607744.2503.1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46150 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdKYLKT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 25 Nov 2017 06:10:19 -0500
In-Reply-To: <1511607744.2503.1.camel@perches.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>, b.zolnierkie@samsung.com, tj@kernel.org, sergei.shtylyov@cogentembedded.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Joe,

On Saturday 25 November 2017 04:32 PM, Joe Perches wrote:
> On Sat, 2017-11-25 at 16:04 +0530, Arvind Yadav wrote:
> []
>> diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
> []
>> @@ -84,7 +84,7 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
>>    */
>>   static struct pdc2027x_pio_timing {
>>   	u8 value0, value1, value2;
>> -} pdc2027x_pio_timing_tbl [] = {
>> +} pdc2027x_pio_timing_tbl[] = {
>>   	{ 0xfb, 0x2b, 0xac }, /* PIO mode 0 */
>>   	{ 0x46, 0x29, 0xa4 }, /* PIO mode 1 */
>>   	{ 0x23, 0x26, 0x64 }, /* PIO mode 2 */
> trivia:
>
> It seems all the <foo>_timing_tbl structs should be const
>
Yes, It should be const. I will push anther patch.

~arvind
