Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CB3C433FE
	for <linux-ide@archiver.kernel.org>; Thu,  7 Oct 2021 12:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9991B6125F
	for <linux-ide@archiver.kernel.org>; Thu,  7 Oct 2021 12:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbhJGMH4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 Oct 2021 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241180AbhJGMHz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 7 Oct 2021 08:07:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB1C061746
        for <linux-ide@vger.kernel.org>; Thu,  7 Oct 2021 05:06:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r18so18384939wrg.6
        for <linux-ide@vger.kernel.org>; Thu, 07 Oct 2021 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=egpUbnymXljqEUVFjTgdXfBwyDrQmhTJL4ZTo/lcmLU=;
        b=hJ69/FFrw1N45ZQ2Y901QUe69V60oxoZauBcf5sFylYKc60zFpbdKv2Y5dHKiqjluB
         pPe5ZR3cmRQA9YTgZIHWIVEHEBgsWVb6Nx9zhu6f1mfOwINDcky7Lzc2h3dqg4X9LLNF
         Y3GhJ/o3sQuMeIZ9xFna1DwGAQCvw3uJc77YcF3THdZlxLUUUBRWu18SkqhIaUDEd9CD
         wW6/psEfsxeUtpiB+11MXSCdCLMuurxtMWGEAXMG1O+Mc8m80zmm6JR18yzwyLdJpJk9
         MAhZAUONCxf4AkJpMuA29xZua04ZP8kYYlYeX3HrdJMMdgnu6bwOTnry6oNw7g5g1VPT
         zCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=egpUbnymXljqEUVFjTgdXfBwyDrQmhTJL4ZTo/lcmLU=;
        b=IiuS5fXUA8uKr3lDC/076p9N9dXQHFTalvnxsJtgmJJdHeRN8Y17cjHjlumEP9SBae
         4JaPOk4hEPUEpv1V9tByaaOkiwrBdijBdGZek1sh1IFx1LXpZYTfnypbXmy9rRmRzAWR
         imerg9fw+w2VH0gGm4se6zpKol6kKolfA0mjDF9ZgfJsvHH/0MGDD0mNe4NJgoYDtebJ
         caIauJWkWmogs/laakCKtx7Mjse7WSGFtqjW/a3oGE4iB1ve1iHi5Zay9pl+dqW+G6NS
         1lveVRpRVoP5puHb9E7rpqVqWSJC1SiJiVza5JmhzY7kJMiGvZZYCck6GX86TsX/FJT4
         2LQg==
X-Gm-Message-State: AOAM532T43bCa2asjxOJXI9YGsrFHXH1lO+FNY2iwKeNoMwT9z+Db+oX
        ewjY94VMxc6UbN8kkjyVdjA=
X-Google-Smtp-Source: ABdhPJyBKIxsGkFcdkIzXHeW6vn1lgfKZTSD6kKKcQdj/DAhZBrm8CRkis0vOD+K2TqQJgXR8jvNzg==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr11290438wmc.90.1633608360459;
        Thu, 07 Oct 2021 05:06:00 -0700 (PDT)
Received: from ipc5 (netacc-gpn-204-213-112.pool.telenor.hu. [5.204.213.112])
        by smtp.googlemail.com with ESMTPSA id q18sm8504965wmc.7.2021.10.07.05.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:05:59 -0700 (PDT)
Message-ID: <23d115f656a3834c24180621667ba87da4d6620f.camel@gmail.com>
Subject: Re: Asmedia 0x0624 support in linux kernel - news, test results
From:   =?ISO-8859-1?Q?Pongr=E1cz_Istv=E1n?= <pongracz.istvan@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org
Date:   Thu, 07 Oct 2021 14:05:58 +0200
In-Reply-To: <YVx5aRInLEvV3eaQ@slm.duckdns.org>
References: <8f4b17c763cb2742c6699d54d7577834b411722b.camel@gmail.com>
         <ab2fde897de1bbbafcec8cf81e05346430c782a4.camel@gmail.com>
         <YVx5aRInLEvV3eaQ@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

2021. 10.  5, kedd keltezéssel 06.12-kor Tejun Heo ezt írta:
> On Tue, Oct 05, 2021 at 02:58:31PM +0200, Pongrácz István wrote:
> > Dear Tejun/All,
> > 
> > I just downloaded the ubuntu kernel source version 5.4.140 and I
> > modified the ahci.c file:
> > 
> > I simply added the extra line with the pci id of the card as shown
> > below:
> >  
> > 	/* Asmedia */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
> >  	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
> > + 	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci }, 
> > 
> > 
> > 
> > I built the kernel and rebooted the machine.
> > Now the kernel can see disks attached to the card.
> > As I just drop some hdds I had around, it seems I got some non-working
> > hdds, so, I will have to get some proven working hdds to populate all
> > the 10 sata channels and test them.
> > 
> > Summary: at this point it seems with the modification above this card
> > could work.
> > 
> > If you need something I should do (test), please let me know, I would
> > be happy to participate in this test.
> 
> Looks like you're on the right path. Once you're happy with the result, can
> you please submit the above as a signed-off patch?
> 
> Thank you.

Hi,

An update about my test, short version:
- I had to change my power supply to be able to feed all hdds
- I have 2 pieces of 10 sata ports cards + motherboard 2
- I installed win10 + asmedia driver provided with the card on a mini
CD -> working.
- I installed linuxmint 20.2 Mate and kernel source 5.4.140
- I added the extra line to the ahci.c as shown above and compiled the
kernel, installed etc.
- with the new kernel, the system started and recognised all the hdds
attached to the cards (2x7 HDDs)

My result after about 24 hours of running, these cards are working
well.

Only one small thing I found, besides of ahci, pata_acpi still visible
 as used kernel modules under the card.
I have no idea, is it ok or not or how to remove pata_acpi if
necessary.

02:00.0 IDE interface: ASMedia Technology Inc. Device 0624 (rev 01)
(prog-if 85 [PCI native mode-only controller, supports bus mastering])
	Subsystem: ASMedia Technology Inc. Device 1060
	Flags: bus master, fast devsel, latency 0, IRQ 126
	I/O ports at d040 [size=8]
	I/O ports at d030 [size=4]
	I/O ports at d020 [size=8]
	I/O ports at d010 [size=4]
	I/O ports at d000 [size=16]
	Memory at 91280000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at 91200000 [disabled] [size=512K]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [800] Advanced Error Reporting
	Kernel driver in use: ahci
	Kernel modules: ahci, pata_acpi

04:00.0 IDE interface: ASMedia Technology Inc. Device 0624 (rev 01)
(prog-if 85 [PCI native mode-only controller, supports bus mastering])
	Subsystem: ASMedia Technology Inc. Device 1060
	Flags: bus master, fast devsel, latency 0, IRQ 127
	I/O ports at c040 [size=8]
	I/O ports at c030 [size=4]
	I/O ports at c020 [size=8]
	I/O ports at c010 [size=4]
	I/O ports at c000 [size=16]
	Memory at 91180000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at 91100000 [disabled] [size=512K]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [800] Advanced Error Reporting
	Kernel driver in use: ahci
	Kernel modules: ahci, pata_acpi


Anyway, I did not find any side effects up to now. 
s.m.a.r.t. is working, ssd/hdd recognised, I already use it with about
13TByte live data (so, software uses these data files on disks without
problem etc.).

So far so good.

@Tejun, I am not a kernel developer, so, not really clear where to send
the "patch" and for which kernel version :)

Thanks,
István




