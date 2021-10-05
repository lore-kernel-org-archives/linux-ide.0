Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593C4C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  5 Oct 2021 16:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362BA6120C
	for <linux-ide@archiver.kernel.org>; Tue,  5 Oct 2021 16:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhJEQOS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJEQOS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2021 12:14:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E01C061749
        for <linux-ide@vger.kernel.org>; Tue,  5 Oct 2021 09:12:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so2380905pjb.5
        for <linux-ide@vger.kernel.org>; Tue, 05 Oct 2021 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=I8qB10X4q+E+ErMdVye6lzg3Si92yxkldCNUXPXFCr4=;
        b=MZzlLvI0roJTS2XIhip9qysQx4cpT5INgVwjQ67RhLq8PzxKrwut+chbz/VdEJmHqR
         KGYI7BEACq+Aq5Cd9GwH2JPpEIoRigUZ184KKrd0hTg1gat705zsAhycLZqouC71z6et
         lNtyzakvtsLq1hcmuwaQv/4pjwvvF1+M8JUN3cG3Cr/8twZhOSoK/EUdy2gR5LRVUG4z
         7FdTlAy+deKrkI/32PZxI6JMBzLM34633SpfAIoS+zQD3gX4G2dUaYICK+bIPPjHYIKK
         1J0eL5/anZu85tgs5SEcQCkFz3WSo2KRl9F02D6gJ5Ps+EyXgIHxw7VQYwg65tNa8bV5
         2Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=I8qB10X4q+E+ErMdVye6lzg3Si92yxkldCNUXPXFCr4=;
        b=KWrwioPVqZl3HYV/Ln5WoW04SPd9CtRC4+eAOU7AfxHrWx+AKUMhGc19BqzxBXpF1K
         E8kIVW3SHjTz9krWNWsl4dhc8yOtYSbbf0F6AhoPSFcOK0D/YpL6ukS9n+QzwBPYhonu
         Oh6OxMtBren0TMT0AP+MeFz33KNZBIuBSs3utlFWrRvnWi8Jybl7fF4GlSu0ADvCnvj5
         gcTtMmbKLszzb41Uc3mmOx1F3cjESGOznH1XuR24gtiCOGMp0i8pcLiYKBiE+qTpmptt
         9s25UyzG6rUO2jxyHLkOYI4hP+syDMTceIIT4OeWc7WCvsHvczXZPXRpoyGOJdCq/4li
         AqWA==
X-Gm-Message-State: AOAM5339q7BCw6nDoygopD2Uxg0JIr2IR4Z++sh94PJjV1nCr2Npz5jc
        u9qDKOCjotlBiacfNvnJlrVmASeqOOo=
X-Google-Smtp-Source: ABdhPJzTDjUIjr1rLycfpOMCZkC3YGMByDz7D2j4zKovXuKhzaoT/F/2S74J0oB4fQGRH9jzaqt0mw==
X-Received: by 2002:a17:90a:ae18:: with SMTP id t24mr4849070pjq.92.1633450347209;
        Tue, 05 Oct 2021 09:12:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q14sm2575820pjm.17.2021.10.05.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:12:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 5 Oct 2021 06:12:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     =?iso-8859-1?Q?Pongr=E1cz_Istv=E1n?= <pongracz.istvan@gmail.com>
Cc:     linux-ide@vger.kernel.org
Subject: Re: Asmedia 0x0624 support in linux kernel - request - update with
 manually built kernel
Message-ID: <YVx5aRInLEvV3eaQ@slm.duckdns.org>
References: <8f4b17c763cb2742c6699d54d7577834b411722b.camel@gmail.com>
 <ab2fde897de1bbbafcec8cf81e05346430c782a4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab2fde897de1bbbafcec8cf81e05346430c782a4.camel@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Oct 05, 2021 at 02:58:31PM +0200, Pongrácz István wrote:
> Dear Tejun/All,
> 
> I just downloaded the ubuntu kernel source version 5.4.140 and I
> modified the ahci.c file:
> 
> I simply added the extra line with the pci id of the card as shown
> below:
>  
> 	/* Asmedia */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
> + 	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci }, 
> 
> 
> 
> I built the kernel and rebooted the machine.
> Now the kernel can see disks attached to the card.
> As I just drop some hdds I had around, it seems I got some non-working
> hdds, so, I will have to get some proven working hdds to populate all
> the 10 sata channels and test them.
> 
> Summary: at this point it seems with the modification above this card
> could work.
> 
> If you need something I should do (test), please let me know, I would
> be happy to participate in this test.

Looks like you're on the right path. Once you're happy with the result, can
you please submit the above as a signed-off patch?

Thank you.

-- 
tejun
