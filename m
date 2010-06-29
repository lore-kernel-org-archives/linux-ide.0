From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH]460EX on-chip SATA driver<kernel 2.6.33><resubmission>
Date: Tue, 29 Jun 2010 03:33:50 +0200
Message-ID: <201006290333.50673.marek.vasut@gmail.com>
References: <201006041226.o54CQH2V017366@amcc.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61884 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab0F2BgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jun 2010 21:36:12 -0400
In-Reply-To: <201006041226.o54CQH2V017366@amcc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com, sr@denx.de, linuxppc-dev@ozlabs.org

Dne P=C3=A1 4. =C4=8Dervna 2010 14:26:17 Rupjyoti Sarmah napsal(a):
> This patch enables the on-chip DWC SATA controller of the AppliedMicr=
o
> processor 460EX.
>=20
> Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@appliedmicro.com>
> Signed-off-by: Prodyut Hazarika <phazarika@appliedmicro.com>
>=20

--SNIP--

> +		dev_err(ap->dev, "%s: Command not pending cmd_issued=3D%d "
> +			"(tag=3D%d) DMA NOT started\n", __func__,
> +			hsdevp->cmd_issued[tag], tag);

Just a nitpick, but don't break strings if possible.
