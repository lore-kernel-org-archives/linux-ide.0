From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 40-wire cable detected when directly connected
Date: Sat, 12 Jan 2008 17:09:26 +0100
Message-ID: <200801121709.26920.bzolnier@gmail.com>
References: <200801101824.04863.Tobias_Mueller@twam.info> <200801121538.47692.bzolnier@gmail.com> <4788CECE.5090207@twam.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:10527 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbYALP5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 10:57:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so617769ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 07:57:34 -0800 (PST)
In-Reply-To: <4788CECE.5090207@twam.info>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias =?utf-8?q?M=C3=BCller?= <Tobias_Mueller@twam.info>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Saturday 12 January 2008, Tobias M=C3=BCller wrote:
> Bartlomiej Zolnierkiewicz schrieb:
> > Please send 'hdparm --Istdout /dev/hdc' output.
>=20
> /dev/sdc:

[...]

Thanks, device has no cable detection (no surprise here, it is a CF car=
d)
so over-riding only host side cable detection won't work.

As a workaround you can try using IDE subsystem siimage driver and pass
"idex=3Data66" option or modify Tejun's patch to also override device s=
ide
cable detection by replacing ATA_CBL_PATA80 with ATA_CBL_PATA40_SHORT.

I've re-read the whole thread and it seems that the possible solution f=
or
Addonics card would be to detect it by PCI Subsystem Vendor/Device IDs.

Could you send the output of 'lspci -vvv -xxx' command?

Bart
