From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: AT91 IDE module
Date: Tue, 23 Nov 2010 22:00:54 +0100
Message-ID: <20101123210054.GA4164@r2bh72.net.upc.cz>
References: <4CEB8FB8.80702@tcz.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.7]:10155 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab0KWU5Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Nov 2010 15:57:25 -0500
Content-Disposition: inline
In-Reply-To: <4CEB8FB8.80702@tcz.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Radovan =?iso-8859-1?Q?V=E1pen=EDk?= <radovan.vapenik@tcz.cz>
Cc: linux-ide@vger.kernel.org

Hi

(cc linux-ide)

On Tue, Nov 23, 2010 at 10:56:08AM +0100, Radovan V=E1pen=EDk wrote:
> Hello Stanislaw,
> i am working on custom board with AT91SAM9263, i am trying to start
> communication with CompactFlash throught your kernel driver (true
> ide mode). I have problem to connect CF to file to /dev directory.
> After module load kernel prints message "ide0 at
> 0xc4866000-0xc4866007,0xc486e006 on irq 132" without some
> identification in /dev/(hda). Can you help me, what can be wrong?
> Wires connections betweent processor and CF should be ok.
>=20
> I have these options in kernel:
> CONFIG_IDE
> CONFIG_IDE_GD
> CONFIG_IDE_GD_ATA
> CONFIG_IDE_TASK_IOCTL
> CONFIG_IDE_PROC_FS
> CONFIG_BLK_DEV_PLATFORM
> CONFIG_BLK_DEV_IDE_AT91

CONFIG_IDE_TIMINGS is also needed, but this should be selected if=20
CONFIG_BLK_DEV_IDE_AT91 was chosen.

If there is no info in /proc/partitions, then disc was not detected.
It's hard to tell why without more verbose messages. Add
"EXTRA_CFLAGS +=3D -DDEBUG" to drivers/ide/Makefile and provide full
dmesg output.

Stanislaw
