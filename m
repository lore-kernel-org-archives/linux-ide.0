From: arnaud atoch <arnaud.atoch@gmail.com>
Subject: Re: Marvell support in ahci
Date: Fri, 15 Apr 2011 21:51:53 +0000
Message-ID: <BANLkTi=EbKGyDP1iMz8FNT-CpA=vuCvHtg@mail.gmail.com>
References: <BANLkTinXaLRBHhrYgetzgv=u8kBg=SQRpQ@mail.gmail.com>
	<BANLkTimQ_0D540RoaAF7j-UgnJuyK87VGw@mail.gmail.com>
	<4DA3942B.3040105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65019 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077Ab1DOVvz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Apr 2011 17:51:55 -0400
Received: by ywj3 with SMTP id 3so830144ywj.19
        for <linux-ide@vger.kernel.org>; Fri, 15 Apr 2011 14:51:54 -0700 (PDT)
In-Reply-To: <4DA3942B.3040105@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

>
> Have you tested a recent kernel with this device? It looks like it should
> have the proper class code so the AHCI driver can load without that specific
> device ID. Adding specific device IDs should only be needed for devices that
> don't do this (like those that identify as RAID or legacy IDE classes).
>

Just tested with 2.6.38-8. Device is not recognized and no module is
attached to it.

02:00.0 SATA controller: Marvell Technology Group Ltd. 88SE614x SATA
II PCI-E controller (rev 01) (prog-if 81)
	Subsystem: ASUSTeK Computer Inc. Device 81d6
	Flags: bus master, fast devsel, latency 0, IRQ 10
	I/O ports at bc00 [size=8]
	I/O ports at b880 [size=4]
	I/O ports at b800 [size=64]
	I/O ports at b480 [size=32]
	Memory at ebdffc00 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at ebd80000 [disabled] [size=256K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [e0] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
