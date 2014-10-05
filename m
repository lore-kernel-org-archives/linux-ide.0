From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ata: pata_imx: Use the SIMPLE_DEV_PM_OPS() macro
Date: Sun, 5 Oct 2014 08:32:09 -0300
Message-ID: <CAOMZO5Dw17pE_YTm2hXHXrPtwe_LQWWak=Vbs6OZA6sRoj5tWw@mail.gmail.com>
References: <1412424186-4296-1-git-send-email-festevam@gmail.com>
	<20141005021111.GA8549@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:47185 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbaJELcL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Oct 2014 07:32:11 -0400
Received: by mail-la0-f49.google.com with SMTP id q1so3070639lam.36
        for <linux-ide@vger.kernel.org>; Sun, 05 Oct 2014 04:32:09 -0700 (PDT)
In-Reply-To: <20141005021111.GA8549@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, Oct 4, 2014 at 11:11 PM, Tejun Heo <tj@kernel.org> wrote:
> On Sat, Oct 04, 2014 at 09:03:06AM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Using the SIMPLE_DEV_PM_OPS() macro can make the code shorter and cleaner.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Applied to libata/for-3.18.  Care to convert other drivers too?

Yes, I can submit patches for other drivers too. Thanks
