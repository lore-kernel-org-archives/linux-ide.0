From: Lin Mac <mkl0301@gmail.com>
Subject: Re: [PATCH v5 0/3] add CNS3xxx AHCI support
Date: Tue, 15 Feb 2011 21:02:07 +0800
Message-ID: <AANLkTimuh_hqfHayieEosMG4v6afj+Hz9U-cUQSNkUUr@mail.gmail.com>
References: <1294557970-654-1-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62501 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab1BONCK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2011 08:02:10 -0500
Received: by fxm20 with SMTP id 20so153725fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2011 05:02:08 -0800 (PST)
In-Reply-To: <1294557970-654-1-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>

2011/1/9  <mkl0301@gmail.com>:
> From: Mac Lin <mkl0301@gmail.com>
>
> v5:
> =A0- Rename ahci_platforms.h to ahci_platform.h
> =A0- s/pltfm/platform/ in ahci_platform.c
>
> v4: http://www.spinics.net/lists/linux-ide/msg39852.html
> =A0- v2 basically, which make SoC-specific changes into separate file=
s
> =A0- Rename module ahci_platform to ahci_platforms, into which link t=
he ahci_platform and the SoC-specific changes
> =A0- No rename of ahci_platform.c
> =A0- Some cosmetic code changes since v2
>
> v3: http://www.spinics.net/lists/arm-kernel/msg109924.html
> =A0- Make the SoC-specific changes into ahci_platform.c directly.
> =A0- Some cosmetic code changes
> =3D> ahci_platform.c is less readable due to SoC-specific changes and=
 macro
>
> v2: http://www.spinics.net/lists/linux-ide/msg39766.html
> =A0- Renaming ahci_platform.c to ahci_pltfm.c for linking SoC specifi=
c changes into ahci_platform, while not changing the module name.
> =A0- Switch ahci_platform to module device table matching to add SoC =
specific support
> =A0- Add CNS3xxx SoC specific AHCI support to ahci_cns3xxx.c
>
> v1: http://www.spinics.net/lists/arm-kernel/msg106236.html
> =A0- Add CNS3xxx SoC specific AHCI support to arch/arm/mach-cns3xxx
> =3D> The changes depends on libahci and libata, i.e. both of them nee=
d to be built into kernel
>
> This patchset is based on linux-2.6.37
>

ping?
Please kindly provide your opinion.

Best Regards,
Mac Lin
