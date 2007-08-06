From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Mon, 06 Aug 2007 14:22:14 +0900
Message-ID: <46B6B006.6000100@gmail.com>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:37168 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbXHFFWV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 01:22:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1035750rvb
        for <linux-ide@vger.kernel.org>; Sun, 05 Aug 2007 22:22:20 -0700 (PDT)
In-Reply-To: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBzZWQ=?= <sedmich@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, hmh@hmh.eng.br

Cc'ing Henrique.  Any ideas?

Micha=C5=82 sed wrote:
> Greetings
>=20
> I'm experiencing double disk spin down issue on my HP nx6310 laptop
> during shut down and suspend to disk. The drive is power down on "Wil=
l
> now halt message" then turned back on and off again with the laptop
> itself. I'm using the newest bios available F.0D, 2.6.23-rc1-mm kerne=
l
> along with Debian Unstable plus fixes from Sidux repository so I have
> the updated shut down script. I have also verified on two other syste=
ms
> [AMD/Nforce based] that the spin down issue has been resolved by the
> Sidux update and I'm certain that this is a hp bios bug or a piix ker=
nel
> module problem.
>=20
> Michael



--=20
tejun
