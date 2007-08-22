From: Kiko Piris <kernel@pirispons.net>
Subject: Re: Problems with IDE on linux 2.6.22.X
Date: Wed, 22 Aug 2007 08:15:08 +0200
Message-ID: <20070822061508.GA16152@bacterio.pirispons.net>
References: <200708212149.12912.jopan@alumni.uv.es> <46CB626F.8020801@gmail.com> <200708220339.45138.jopan@alumni.uv.es> <46CBA0F0.70503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound.mailhop.org ([63.208.196.171]:3699 "EHLO
	outbound.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226AbXHVJmI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 05:42:08 -0400
Content-Disposition: inline
In-Reply-To: <46CBA0F0.70503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
Cc: =?iso-8859-1?Q?Jos=E9_Luis_Pati=F1o_Andr=E9s?= <jopan@alumni.uv.es>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 22/08/2007 at 04:35 +0200, Rene Herman wrote:

> The old SATA driver available from the IDE menu also does not support=
 your=20
> chip, so I don't believe there are any workarounds -- you'll need the=
 issue=20
> fixed.

I had the same issue when I compiled 2.6.22 on my T60 (SATA_AHCI drives
my hd). I workarounded it selecting IDE_GENERIC as a module.

Worth a try=E2=80=A6

--=20
Kiko
Private mail is preferred encrypted:
http://www.pirispons.net/pgpkey.html
