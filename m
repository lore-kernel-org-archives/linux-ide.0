From: Daniel Drake <dsd@gentoo.org>
Subject: Re: Promise TX4200 support?
Date: Mon, 18 Jul 2005 23:37:56 +0100
Message-ID: <42DC2F44.7000708@gentoo.org>
References: <42DBFC9E.1040607@gentoo.org> <42DC0A99.2010304@solnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:30385 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261314AbVGRWfG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jul 2005 18:35:06 -0400
In-Reply-To: <42DC0A99.2010304@solnet.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TWFydGluIFBvdm9sbsO9?= <martin.povolny@solnet.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Martin,

Martin Povoln=C3=BD wrote:
> We are succesfully running patched sata_promise with 3 disks in a
> raid5/raid1 setup. (Patched against ubuntu linux-image 2.6.11-1-686
> package.)

Could you please either send in your patch, or tell me which board_ set=
ting=20
(2037x/20319/20619) the device ID table should include so I can write s=
ubmit=20
one myself.

> 'lspci -v' says:
>=20
> 02:02.0 RAID bus controller: Promise Technology, Inc.: Unknown device
> 3519 (rev 02)
>         Subsystem: Promise Technology, Inc.: Unknown device 3519
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
>         I/O ports at dc00 [size=3D128]
>         I/O ports at d800 [size=3D256]
>         Memory at feaff000 (32-bit, non-prefetchable) [size=3D4K]
>         Memory at feac0000 (32-bit, non-prefetchable) [size=3D128K]
>         Expansion ROM at feae0000 [disabled] [size=3D64K]
>         Capabilities: [60] Power Management version 2

Thanks,
Daniel
