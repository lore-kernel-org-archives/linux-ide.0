From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 40-wire cable detected when directly connected
Date: Sat, 12 Jan 2008 15:38:47 +0100
Message-ID: <200801121538.47692.bzolnier@gmail.com>
References: <200801101824.04863.Tobias_Mueller@twam.info> <4786E82A.7010208@gmail.com> <47875755.4000109@twam.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:50633 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762854AbYALO0j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 09:26:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so610574ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 06:26:37 -0800 (PST)
In-Reply-To: <47875755.4000109@twam.info>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias =?utf-8?q?M=C3=BCller?= <Tobias_Mueller@twam.info>
Cc: linux-ide@vger.kernel.org

On Friday 11 January 2008, Tobias M=C3=BCller wrote:
> Tejun Heo schrieb:
> > I don't know very well about CF but does it even fill UDMA/33?  Wha=
t
> > does 'dd if=3D/dev/sdc of=3D/dev/null bs=3D1M count=3D16 iflag=3Ddi=
rect' say?  You
> > can increase count for more reliable result.
>=20
> 16+0 Datens=C3=A4tze ein
> 16+0 Datens=C3=A4tze aus
> 16777216 Bytes (17 MB) kopiert, 0,561688 s, 29,9 MB/s
>=20
> And hdparm -I /dev/sdc says it should be compatible to udma5.

[...]

Please send 'hdparm --Istdout /dev/hdc' output.

Thanks,
Bart
