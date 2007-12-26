From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 00/63] ide-cd: redux
Date: Wed, 26 Dec 2007 16:43:29 +0100
Message-ID: <20071226154329.GA4713@gollum.tnic>
References: <200712200148.49690.bzolnier@gmail.com> <20071225140514.fa13f5ac.akpm@linux-foundation.org>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp107.plus.mail.re1.yahoo.com ([69.147.102.70]:45490 "HELO
	smtp107.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751111AbXLZPpj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Dec 2007 10:45:39 -0500
Content-Disposition: inline
In-Reply-To: <20071225140514.fa13f5ac.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Dec 25, 2007 at 02:05:14PM -0800, Andrew Morton wrote:
> On Thu, 20 Dec 2007 01:48:49 +0100 Bartlomiej Zolnierkiewicz <bzolnie=
r@gmail.com> wrote:
>=20
> > This patch series is a major rework of the ide-cd driver.
>=20
> woo-hoo.
>=20
> > PS ide-cd Maintainer position is still open...
>=20
> boo-hoo.
>=20
> I wish someone would fix that "The drive appears confused (ireason =3D
> 0x%02x)" thing.  I had a go a while back but iirc the reporter disapp=
eared
> on me.  It is somewhat common.
>=20
> Or do you think this patch might indeed fix it?

Andrew, take a look at patch #12 in this series: "ide-cd: fix "missing =
data" handling in
cdrom_pc_intr()."
--=20
Regards/Gru=DF,
    Boris.
