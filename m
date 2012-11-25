From: Jack Wang <jack.wang.usish@gmail.com>
Subject: Re: AHCI performance and IRQ load
Date: Sun, 25 Nov 2012 15:58:10 +0800
Message-ID: <CA+res+SicJw8RBz+02L+bOZRxa8j8y9ni=GzrMm=Ly3YYM6sPQ@mail.gmail.com>
References: <50AF9E0F.8030300@missinglinkelectronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57414 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab2KYH6L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Nov 2012 02:58:11 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so4983280iea.19
        for <linux-ide@vger.kernel.org>; Sat, 24 Nov 2012 23:58:11 -0800 (PST)
In-Reply-To: <50AF9E0F.8030300@missinglinkelectronics.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Cc: linux-ide@vger.kernel.org, Lorenz Kolb <lorenz.kolb@missinglinkelectronics.com>

2012/11/24 Joachim Foerster <joachim.foerster@missinglinkelectronics.com>:
> Hi all,
>
> we are currently working on a high performance storage test solution using
> SATA/AHCI. Due to having performance issues with small block sizes (high
> interrupt load), we did some research and came across a FAST12 paper by
> Intel: "When Poll is Better than Interrupt".
> The authors do suggest a synchronous completion model or even a hybrid mode
> with support for async and sync completion - for future SSDs.
>
> Does anybody know, if there already is work going on to incorporate such
> functionality into the block layer & backends (meaning, among others:
> libata/ahci)?
>
> Another thing, which seemed promising was AHCI's CommandCompletionCoalescing
> (CCC) feature. However most AHCI controllers don't seem to support this
> feature.
> Anybody aware of AHCI controllers having CCC support?
>
> There seemed to be a discussion about CCC support for the ahci driver some
> years ago http://www.spinics.net/lists/linux-ide/msg02994.html, but
> obviously no code came out of it - or is there a known patchset?
>
> Thanks,
> --

Hi,

Maybe  patchset ---- x86, MSI, AHCI: Support multiple MSIs should help
in your case.

regards!

Jack
