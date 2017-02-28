From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] ide-generic: added messages in case of PCI IDE
 devices
Date: Tue, 28 Feb 2017 20:25:10 +0300
Message-ID: <d74a625e-ef48-146c-3c40-de79403da03d@cogentembedded.com>
References: <20170221142249.GC11234@giustizia>
 <418946e5-38e6-ca97-fce1-543988a5f06d@cogentembedded.com>
 <20170222003831.GA14251@giustizia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36356 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdB1ReO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2017 12:34:14 -0500
Received: by mail-lf0-f48.google.com with SMTP id y193so8690772lfd.3
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2017 09:32:26 -0800 (PST)
In-Reply-To: <20170222003831.GA14251@giustizia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Miller <davem@davemloft.net>, petkovbb@gmail.com

On 02/22/2017 03:38 AM, Luiz Carlos Ramos wrote:

>> On 02/21/2017 05:22 PM, Luiz Carlos Ramos wrote:
>>
>>> Two messages are now displayed (at "warn" level) to make sure the user
>>> is aware that PCI IDE devices were detected at common addresses (0x1f0
>>> and 0x170) and that they will not be managed by ide-generic, but rather
>>> delegated to its specific driver.
>>>
>>> Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
>>> ---
>>> drivers/ide/ide-generic.c | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
>>> index ee11edcdba3170c077381d603918498d79ffa3bb..2204819ef73612deed4ebfe58c69cdadb40fa53b 100644
>>> --- a/drivers/ide/ide-generic.c
>>> +++ b/drivers/ide/ide-generic.c
>>> @@ -125,9 +125,19 @@ static int __init ide_generic_init(void)
>>>
>>> 		if (primary == 0)
>>> 			probe_mask |= 0x1;
>>> +		else {
>>> +			printk(KERN_WARN DRV_NAME ": PCI IDE device detected at 0x%4.4x."
>>
>>    Also, please use pr_warn().
>>
>
> This code is quite old, and it is in deep maintenance phase.
>
> Every other message in ide-generic.c is implemented as printk(...),
> but to be fair, there are not so many of them.
>
> Given that fact, would it be better to change these two ones to be
> inserted to pr_warn() as suggested (and then having a mix of printk()
> and pr_warn() in the code), or to "allow" two more printk() in the code
> and having checkpatck.pl complaining?
>
> I really don't know what is better or worse. Both can be implemented,
> and there are a mix of advantages and disadvantages in each side.
>
> I'd like to hear from you and colleagues about how to proceed.

    I'd prefer a checkpatch-clean patch. Though I don't think DaveM would take 
further cleanups (printk -> pr_<foo>).

MBR, Sergei

