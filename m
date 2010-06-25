From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ahci_platform: Provide for vendor specific init
Date: Fri, 25 Jun 2010 18:25:47 +0900
Message-ID: <AANLkTingJcByWdlZZFv5vhyRBqTFuLfpEDqARx84hpQu@mail.gmail.com>
References: <1277441858-26993-1-git-send-email-jassisinghbrar@gmail.com>
	<20100625074904.GA32340@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41426 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab0FYJZs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 05:25:48 -0400
Received: by vws9 with SMTP id 9so3655211vws.19
        for <linux-ide@vger.kernel.org>; Fri, 25 Jun 2010 02:25:47 -0700 (PDT)
In-Reply-To: <20100625074904.GA32340@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Jassi Brar <jassi.brar@samsung.com>

On Fri, Jun 25, 2010 at 4:49 PM, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> On Fri, Jun 25, 2010 at 01:57:38PM +0900, Jassi Brar wrote:
>> From: Jassi Brar <jassi.brar@samsung.com>
>>
>> Some AHCI implementations may use Vendor Specific HBA[A0h, FFh]
>> and/or Port[70h, 7Fh] registers to 'prepare' for initialization.
>> For that, the platform needs memory mapped address of AHCI registers.
>>
>> This patch adds the 'mmio' argument and reorders the call to
>> platform init function.
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>
> Thanks for the patch. Looks good, but see some comments below.
> (Plus some comments on Jeff's reply)

Ok, will resend. Thanks.
