Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96CCC433B4
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 23:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA18610CA
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 23:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhDIXi4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Apr 2021 19:38:56 -0400
Received: from m12-18.163.com ([220.181.12.18]:59784 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235151AbhDIXi4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 9 Apr 2021 19:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=PMyya
        haBzqHvEXTUg5sQu5drqNL/NXL/3ExuqhxFwPA=; b=bk3aRJNWjzAGnPH3BNpvj
        OVALxHyXd4R+ctOXM4LpFTDvHISmuhV+7etmtq47O4tAIUg9WsWPj98wohG/MT4E
        VsVMfP/w6mV530Y2r8mxuVeoe58ZL7LrJT07A64t8+ce6pvfLmMM0KLVgEdwLgyn
        DMSqYHNCw46FnhT8yny5kA=
Received: from localhost (unknown [119.137.53.45])
        by smtp14 (Coremail) with SMTP id EsCowABnYO5m5XBgTMFpdA--.12868S2;
        Sat, 10 Apr 2021 07:38:15 +0800 (CST)
Date:   Sat, 10 Apr 2021 07:38:14 +0800
From:   angkery <angkery@163.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH] pata_ipx4xx_cf: Fix unsigned comparison with less than
 zero
Message-ID: <20210410073814.00003b86.angkery@163.com>
In-Reply-To: <e6bf7f02-f0b8-b0c4-2253-62a55ea98d17@gmail.com>
References: <20210409135426.1773-1-angkery@163.com>
        <e74ec570-96b6-23ce-edd5-b5a38628963a@gmail.com>
        <e6bf7f02-f0b8-b0c4-2253-62a55ea98d17@gmail.com>
Organization: yulong
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EsCowABnYO5m5XBgTMFpdA--.12868S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW7KF1rKw4kCr4UZF1xuFg_yoW8GFWxpF
        47Ca4j9rWvq342k39rtrsrZFyrta1rGryIv3y3CrWYvr1qq3Z7JFyagrWj9F4q9r4xGr10
        vry5tw47uF47ZaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMVbkUUUUU=
X-Originating-IP: [119.137.53.45]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbiLA9vI1spZ9kimAABsY
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 9 Apr 2021 20:02:56 +0300
Sergei Shtylyov <sergei.shtylyov@gmail.com> wrote:

> On 4/9/21 7:49 PM, Sergei Shtylyov wrote:
> 
> >> From: Junlin Yang <yangjunlin@yulong.com>
> >>
> >> The return from the call to platform_get_irq() is int, it can be
> >> a negative error code, however this is being assigned to an
> >> unsigned int variable 'irq', so making 'irq' an int, and change
> >> the position to keep the code format.
> >>
> >> ./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
> >> WARNING: Unsigned expression compared with zero: irq > 0  
> > 
> >    I'd understand < 0... but > 0? What tool warned about this issue?
> >   
> > > yes, by coccicheck, i will update commits information.
> >
> >> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> >> ---
> >>  drivers/ata/pata_ixp4xx_cf.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/ata/pata_ixp4xx_cf.c
> >> b/drivers/ata/pata_ixp4xx_cf.c index abc0e87..43215a4 100644
> >> --- a/drivers/ata/pata_ixp4xx_cf.c
> >> +++ b/drivers/ata/pata_ixp4xx_cf.c
> >> @@ -135,12 +135,12 @@ static void ixp4xx_setup_port(struct
> >> ata_port *ap, 
> >>  static int ixp4xx_pata_probe(struct platform_device *pdev)
> >>  {
> >> -	unsigned int irq;  
> > 
> >    Oops, not sure how I missed that. :-/
> >    Thanks for fixing my overlook. :-)  
> 
>    Forgot to add my
> 
> Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> 
> > [...]  
> 
> MBR, Sergei


