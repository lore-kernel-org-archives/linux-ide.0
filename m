From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] [STACK] >3k call path in ide
Date: Wed, 16 Jun 2004 12:00:08 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040616100008.GB2548@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <20040615163445.6b886383.rddunlap@osdl.org> <200406160911.11985.jolt@tuxbox.org> <20040616094737.GA2548@wohnheim.fh-wedel.de> <40D01928.1080309@tuxbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.fh-wedel.de ([213.39.232.194]:61639 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266229AbUFPKAR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2004 06:00:17 -0400
Content-Disposition: inline
In-Reply-To: <40D01928.1080309@tuxbox.org>
List-Id: linux-ide@vger.kernel.org
To: Florian Schirmer <jolt@tuxbox.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 June 2004 11:55:52 +0200, Florian Schirmer wrote:
>=20
> >Leak memory.
>=20
> Nope. It will deadlock just like the original patch because failed fa=
lls=20
> through to err_kfree which then will jump to failed...

Both, leak memory on good path, deadlock on error path.  Fun patch. :)

J=F6rn

--=20
It is better to die of hunger having lived without grief and fear,
than to live with a troubled spirit amid abundance.
-- Epictetus
