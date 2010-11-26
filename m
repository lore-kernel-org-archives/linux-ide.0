From: Alessandro Tagliapietra <tagliapietra.alessandro@gmail.com>
Subject: Re: Message
Date: Fri, 26 Nov 2010 08:41:59 +0100
Message-ID: <AANLkTikBgxBsGudfiN-xnN-KRNaanFrPpwOH_EMJ-oic@mail.gmail.com>
References: <AANLkTinSigE4JPsFByPCkFd-+_oXQwR-V9=AsSH9Warz@mail.gmail.com>
	<1290755809.2678.14.camel@edumazet-laptop>
	<AANLkTi=8nWFHeJ0Z-WhprNqZMGprMRG5LQ+b3wKoMWWv@mail.gmail.com>
	<AANLkTi=bELgtgcWcy59KCvKwWWiuVZBb7e_hTSBHZ4cH@mail.gmail.com>
	<20101126073805.GB14282@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52736 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab0KZHmA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Nov 2010 02:42:00 -0500
In-Reply-To: <20101126073805.GB14282@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Alessandro Tagliapietra <tagliapietra.alessandro@gmail.com>, Eric Dumazet <eric.dumazet@gmail.com>, linux-kernel@vger.kernel.org, linux-ide <linux-ide@>

2010/11/26 Borislav Petkov <bp@alien8.de>:
> adding linux-ide.

Thank you, i've also attached at this ubuntu bug:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/658521
the dmesg from ubuntu 10.10 and 11.04 with bios settings as RAID and AHCI.
I think that setting is only for Sata-2, as the drives are not seen by
the bios in the drive list. Just on the boot orded it see "IDE:
Marvell RAiD".
The drives are seen by the marvell controller after the bios, where
i've setup the raid 0 on them.

Best Regards

Alessandro Tagliapietra
