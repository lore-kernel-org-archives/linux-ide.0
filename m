From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Date: Thu, 09 Nov 2006 20:03:03 +0100
Message-ID: <45537B67.6050804@gmail.com>
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com> <d9a083460611090855w3b3a9eb6w347a24b1e704ca61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tirith.ics.muni.cz ([147.251.4.36]:64644 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1754708AbWKITDP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 14:03:15 -0500
In-Reply-To: <d9a083460611090855w3b3a9eb6w347a24b1e704ca61@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jano <jasieczek@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jano wrote:
[...]
> @@ -607,7 +611,7 @@
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> -# CONFIG_BLK_DEV_HD_IDE is not set
> +CONFIG_BLK_DEV_HD_IDE=3Dy

This was not definitely a good choice. Disable it.

  =E2=94=82 Symbol: BLK_DEV_HD_IDE [=3Dn]                              =
               =E2=94=82
  =E2=94=82 Prompt: Use old disk-only driver on primary interface      =
             =E2=94=82
  =E2=94=82   Defined at drivers/ide/Kconfig:118                       =
             =E2=94=82
  =E2=94=82   Depends on: IDE && BLK_DEV_IDE && (X86 || SH_MPC1211)    =
             =E2=94=82
  =E2=94=82   Location:                                                =
             =E2=94=82
  =E2=94=82     -> Device Drivers                                      =
             =E2=94=82
  =E2=94=82       -> ATA/ATAPI/MFM/RLL support                         =
             =E2=94=82
  =E2=94=82         -> ATA/ATAPI/MFM/RLL support (IDE [=3Dy])          =
               =E2=94=82
  =E2=94=82           -> Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy su=
pport (BLK_D =E2=94=82

> CONFIG_BLK_DEV_IDEDISK=3Dy
> # CONFIG_IDEDISK_MULTI_MODE is not set
> CONFIG_BLK_DEV_IDECD=3Dm
> @@ -618,7 +622,7 @@
> #
> # IDE chipset support/bugfixes
> #
> -CONFIG_IDE_GENERIC=3Dy
> +CONFIG_IDE_GENERIC=3Dm
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=3Dy
> CONFIG_IDEPCI_SHARE_IRQ=3Dy
> @@ -658,7 +662,7 @@
> CONFIG_BLK_DEV_IDEDMA=3Dy
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=3Dy
> -# CONFIG_BLK_DEV_HD is not set
> +CONFIG_BLK_DEV_HD=3Dy

And try to turn "VIA82CXXX chipset support" to <*>, i.e. built-in (some=
body
holds regions of ide0 and ide1, let's try via driver to probe first).

regards,
--=20
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
