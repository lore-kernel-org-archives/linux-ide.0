From: "Grant Grundler" <grundler@google.com>
Subject: Re: [git patches] IDE fixes
Date: Fri, 20 Jun 2008 11:35:20 -0700
Message-ID: <da824cf30806201135y7235df5cocd1dfe30d9cae54a@mail.gmail.com>
References: <200806202007.38081.bzolnier@gmail.com>
	 <20080620190948.537f7f7a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:51586 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbYFTSfa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 14:35:30 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id m5KIZMUY016136
	for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 19:35:22 +0100
Received: from wf-out-1314.google.com (wfd27.prod.google.com [10.142.4.27])
	by zps36.corp.google.com with ESMTP id m5KIZLwe018063
	for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 11:35:21 -0700
Received: by wf-out-1314.google.com with SMTP id 27so1431037wfd.5
        for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 11:35:21 -0700 (PDT)
In-Reply-To: <20080620190948.537f7f7a@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 20, 2008 at 11:09 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
>> +     PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS1GCF45", 0x709b1bf1, 0xf68b632),
>
> That one seems to be a digit short - is it 0x0f68b632 or a typo ?

Typo. Original patch seems to have 0xf68b6f32

http://lists.infradead.org/pipermail/linux-pcmcia/2008-May/005496.html

grant


>
>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
