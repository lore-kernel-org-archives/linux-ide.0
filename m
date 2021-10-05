Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B084FC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  5 Oct 2021 12:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F206124F
	for <linux-ide@archiver.kernel.org>; Tue,  5 Oct 2021 12:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhJENA6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhJENA5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2021 09:00:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333FCC061749
        for <linux-ide@vger.kernel.org>; Tue,  5 Oct 2021 05:59:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z20so26759584edc.13
        for <linux-ide@vger.kernel.org>; Tue, 05 Oct 2021 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ty1oXg55o6eskJRilyG4+4WvJn/E7j8FJxGjCFghgV4=;
        b=bov8jHJfz0++/u1D7/oR9tT8Cwb6G6w0ARCpgxjmKBlPJQe/kruMTfxWudmE+8R97n
         3yhPx81CZhJuLrd0opPJIYmDwvBJffK8Vd1UvKNdrQo7yH5kW5m+tyuBngM6BhQfj8Jb
         0eJ1WbmakxDBX8UPvvkG7V09pA1FD333CULrH6B3q3/89p29ZNK3c77vG2DiJlJMG6o9
         EnEQjmEkQxZw1kiBAmU9P0WjktT0UxKPV8Nq+6WPO7ezpp9fV/rjzj/Y/9nYNtRwuAQZ
         lq2yAUqZraIYt+bAUAqI25Rop5axgeIKdM3QczrEu2+8u6yRURpRs76LaMUXzllqqra9
         jprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ty1oXg55o6eskJRilyG4+4WvJn/E7j8FJxGjCFghgV4=;
        b=LpccOJUvSxwG1dsGPl1lUaemia1AQ1V9fv/Po7gwTRDokhkoWnMaSxVeKpkLnbGQSl
         EpgwuqfLeyB/2Q7Kxw4i/8Dnq6TOA/frygvJZUWSOkv9UhJys5epOjExhMwC34eVRI/c
         Sv5OaIg+riBZr+b/3r6QS1Pj6xDKG6Ly5kRdzTL5qtuPIGCKH6TJy9nI960lyETi8LPa
         m4f47qrrBSFS7zSH50YBkGHKL2cKQNvpU7jN3ZAgieza3VQxZ+f6HHjMRrK4gJWd66/o
         E4Z0VVV4Q7Gy+Nlwmq7D6v2zCaGoGYe5OrhGc2q+m8O+Qcu7q2Dskv4m4CU3hwKn4AnK
         lcJQ==
X-Gm-Message-State: AOAM532RtoSyXJ1AXifxlauI8iih3i+17EvyxTxSsKOZdMezHU1W8HMC
        6vjStYDC/1KeT4A/EYg2vpM=
X-Google-Smtp-Source: ABdhPJybTFI3C/Ru0js0GkdyrIRuk/ZGoQ2cHtKlPZdUQGzlpvNh9y6MxSRpXmrQO6MDgMWaQrO8gA==
X-Received: by 2002:a17:906:f184:: with SMTP id gs4mr11989239ejb.116.1633438713745;
        Tue, 05 Oct 2021 05:58:33 -0700 (PDT)
Received: from ipc5 (netacc-gpn-4-195-71.pool.telenor.hu. [84.224.195.71])
        by smtp.gmail.com with ESMTPSA id u18sm401206edo.4.2021.10.05.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 05:58:33 -0700 (PDT)
Message-ID: <ab2fde897de1bbbafcec8cf81e05346430c782a4.camel@gmail.com>
Subject: Re: Asmedia 0x0624 support in linux kernel - request - update with
 manually built kernel
From:   =?ISO-8859-1?Q?Pongr=E1cz_Istv=E1n?= <pongracz.istvan@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org
Date:   Tue, 05 Oct 2021 14:58:31 +0200
In-Reply-To: <8f4b17c763cb2742c6699d54d7577834b411722b.camel@gmail.com>
References: <8f4b17c763cb2742c6699d54d7577834b411722b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Tejun/All,

I just downloaded the ubuntu kernel source version 5.4.140 and I
modified the ahci.c file:

I simply added the extra line with the pci id of the card as shown
below:
 
	/* Asmedia */
 	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
+ 	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci }, 



I built the kernel and rebooted the machine.
Now the kernel can see disks attached to the card.
As I just drop some hdds I had around, it seems I got some non-working
hdds, so, I will have to get some proven working hdds to populate all
the 10 sata channels and test them.

Summary: at this point it seems with the modification above this card
could work.

If you need something I should do (test), please let me know, I would
be happy to participate in this test.

Thank you.

István Pongrácz






2021. 10.  5, kedd keltezéssel 10.27-kor Pongrácz István ezt írta:
> Dear Tejun/All,
> 
> EDIT: sorry, the first email sent as html, now this is a clean txt
> version of it. Sorry again.
> 
> ----
> 
> I checked the ahci.c after I failed to use Asmedia sata card
> (pci:1b21-
> 0624-1b21-1060;01-01-85;detected;storage;pata_acpi;ASMedia Technology
> Inc.;IDE interface;ASMedia Technology Inc.) in linux, using
> kernel 5.11.0-37-lowlatency.
> 
> As I found no answer/solution on the net, as a final resort I write
> to
> you about this card and try to ask you to look after this chip.
> 
> Technically this pci sata card is a 10 ports card, using (as I can
> see)
> 3 chips in cascade to get 2x5 sata ports.
> 
> Regarding to the recent Asmedia support, I found this: 
> https://github.com/torvalds/linux/blob/master/drivers/ata/ahci.c#L588
> 
> 
> 	/* Asmedia */
> 	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
> 	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
> 	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
> 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
> 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
> 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
> 
> 
> So, unfortunately the 0624 is not there yet.
> 
> Thank you all for your time an efforts regarding the development!
> 
> Best regards,
> Mr. István Pongrácz

