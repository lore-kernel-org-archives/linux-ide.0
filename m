From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Mon, 28 Jan 2008 09:44:28 +0900
Message-ID: <479D256C.1090507@gmail.com>
References: <4794459C.3090200@gmail.com> <4796DC44.6010100@gmail.com>	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>	 <4797ECF3.5000306@gmail.com>	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>	 <4797F8D0.6060302@gmail.com>	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>	 <47980B71.3000408@gmail.com>	 <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>	 <4798AA88.5080107@gmail.com> <864c1e490801240840q5423a1beuf9b4b3a43416db2b@mail.gmail.com> <4798C617.10601@gmail.com> <4798CA71.20707@gmail.com> <4798CC90.4040707@gmail.com> <4798CCDF.9070305@gmail.com> <4798CE10.2050005@gmail.com> <4798D4A2.7030303@gmail.com> <47991AD9.6050804@gmail.com> <47993686.5040405@gmail.com> <479939E3.4020307@gmail.com> <479D0AB5.6070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:29026 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbYA1Aoe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 19:44:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2647116wah.23
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 16:44:34 -0800 (PST)
In-Reply-To: <479D0AB5.6070203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Thomas Evans wrote:
> Tejun and all -
>=20
> I have a new log - I got somewhat further by setting this bit when
> init'd via HOST_CTRL:
>=20
> Bit [28]: PERR Rpt Dsbl (R/W) =96 PERR Report Disable. This bit, when=
 set
> to one, disables reporting of PCI bus
> parity errors to the Command Execution State Machine (such errors wou=
ld
> otherwise cause the state machine to stop
> and report an error in the Command Error register).

Hmmm... That's strange.  If PERR makes a difference, it means PCI bus
side is contributing to the problem but only when PMP is attached while
directly attached drive works just fine?

> This causes the PMP device to be noticed, but the first qc command ne=
ver
> completes.
>=20
> Please see the log and see if there is anything obvious.

Thanks but I'm as lost as you are.  :-(

--=20
tejun
