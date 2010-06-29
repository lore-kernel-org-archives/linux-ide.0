From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH]460EX on-chip SATA driver<kernel 2.6.33><resubmission>
Date: Tue, 29 Jun 2010 16:44:15 +0400
Message-ID: <20100629124415.GA32738@oksana.dev.rtsoft.ru>
References: <201006041226.o54CQH2V017366@amcc.com>
 <201006290333.50673.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56191 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0F2MoV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2010 08:44:21 -0400
Content-Disposition: inline
In-Reply-To: <201006290333.50673.marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Rupjyoti Sarmah <rsarmah@amcc.com>, linux-ide@vger.kernel.org, sr@denx.de, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

On Tue, Jun 29, 2010 at 03:33:50AM +0200, Marek Vasut wrote:
> Dne P=C3=A1 4. =C4=8Dervna 2010 14:26:17 Rupjyoti Sarmah napsal(a):
> > This patch enables the on-chip DWC SATA controller of the AppliedMi=
cro
> > processor 460EX.
> >=20
> > Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com>
> > Signed-off-by: Mark Miesfeld <mmiesfeld@appliedmicro.com>
> > Signed-off-by: Prodyut Hazarika <phazarika@appliedmicro.com>
> >=20
>=20
> --SNIP--
>=20
> > +		dev_err(ap->dev, "%s: Command not pending cmd_issued=3D%d "
> > +			"(tag=3D%d) DMA NOT started\n", __func__,
> > +			hsdevp->cmd_issued[tag], tag);
>=20
> Just a nitpick, but don't break strings if possible.

Note that in this particular case breaking strings was OK, and
was actually done in a clever manner.

That is, I doubt that anyone grep for error messages with
regexps, so grep "Command not pending" or grep "DMA NOT started"
would work.

This makes the code more readable (literally, because you don't
have to scroll to see dev_err's arguments) without sacrificing
grep'ability.

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
