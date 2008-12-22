From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: blacklist NCQ on OCZ CORE 2 SSD
Date: Mon, 22 Dec 2008 17:14:12 +0900
Message-ID: <494F4C54.9040602@kernel.org>
References: <4946C96B.2030603@dsrg.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50892 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbYLVIO2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Dec 2008 03:14:28 -0500
In-Reply-To: <4946C96B.2030603@dsrg.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?THVib23DrXIgQnVsZWo=?= <lubomir.bulej@dsrg.mff.cuni.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Lubom=C3=ADr Bulej wrote:
> Hello,
>=20
> after putting a 250G OCZ CORE v2 SSD into my notebook, I have to endu=
re
> several invocations of the ata EH before the kernel decides to disabl=
e
> NCQ due too many errors. The drive reports NCQ of depth 1, which is
> probably useless anyway.
>=20
> The patchlet below saves me the waiting for the completion of several
> ata EH invocations, but I'm not sure if this is the right solution.
> Attached are two dmesg dumps, one with errors and the other with the
> patchlet compiled in. Attached is also "hdparm -I" of the drive.

Aieee.. these SSDs.  Can't they hire someone who actually know ATA
before putting these devices out on the market?  :-(

Anyways, I don't think there's much we can do other than blacklisting
it.  Can you please resend with proper S-O-B?

--=20
tejun
