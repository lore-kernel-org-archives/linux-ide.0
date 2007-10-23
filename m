From: Tejun Heo <htejun@gmail.com>
Subject: Re: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Tue, 23 Oct 2007 21:26:14 +0900
Message-ID: <471DE866.7040908@gmail.com>
References: <47099C24.3010504@mandic.com.br> <471DAA1C.4070608@gmail.com> <471DC728.60705@mandic.com.br> <471DC8F1.9090501@gmail.com> <471DCA74.503@mandic.com.br> <471DCB33.5070108@gmail.com> <471DD288.7010902@mandic.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:56753 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbXJWM0a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 08:26:30 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1707498wah
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 05:26:28 -0700 (PDT)
In-Reply-To: <471DD288.7010902@mandic.com.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Cc: Jeff Garzik <jeff@garzik.org>, debian-devel@lists.debian.org, linux-ide@vger.kernel.org, miquels@cistron.nl

Renato S. Yamane wrote:
> Tejun Heo wrote:
>> Renato S. Yamane wrote:
>>> Tejun Heo wrote:
>>>> Renato S. Yamane wrote:
>>>>> Fixed. Patch is attached. Thanks!
>>>>
>>>> Can you write up something for other debian users so that it can be
>>>> included in the linux-ata page && cc Jeff Garzik?
>>>
>>> Sorry my friend, but I don't have e-mail from Jeff Garzik.
>>
>> cc'd.
> 
> Jeff, patch is attached.
> When I shutdown my laptop, I receive some warnings about linux-ata.
> Tejun suggest remove -h option on halt script and this work fine.

Ehh... I meant something along the line of...

"Info for Debian VERSION users : if you see this warning there are
several solutions... blah blah".

-- 
tejun
