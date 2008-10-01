From: Tejun Heo <tj@kernel.org>
Subject: Re: nx6325 and frequent head unloads
Date: Wed, 01 Oct 2008 11:46:12 +0900
Message-ID: <48E2E474.5030903@kernel.org>
References: <20080919002701.1537ca54@incubo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35187 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbYJACrw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 22:47:52 -0400
In-Reply-To: <20080919002701.1537ca54@incubo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "A. Klitzing" <aklitzing@online.de>
Cc: linux-ide@vger.kernel.org

A. Klitzing wrote:
> Hi there,
>=20
> my harddrive has this problem [1], too. Here are the outputs of my
> notebook "HP nx6325 (EY351ET)".
>=20
> Workaround: hdparm -B 254 /dev/sda
> But the hdd will be warmer than usual.
>=20
> Best regards,
> Andr=C3=A9 Klitzing
>=20
> [1]
> http://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perfor=
m_frequent_head_unloads_under_Linux

added.

--=20
tejun
