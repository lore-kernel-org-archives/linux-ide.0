From: Tejun Heo <tj@kernel.org>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Sun, 16 Nov 2008 23:24:43 +0900
Message-ID: <1226845483.20834.1.camel@linux-szv5.site>
References: <491C9A4F.1020801@tlinx.org> <491FB7E2.2030105@kernel.org>
	 <18719.65298.689618.835202@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38176 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbYKPOVb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 09:21:31 -0500
In-Reply-To: <18719.65298.689618.835202@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Linda Walsh <lkml@tlinx.org>, LKML <linux-kernel@vger.kernel.org>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

2008-11-16 (=EC=9D=BC), 12:08 +0100, Mikael Pettersson wrote:
>  > Mikael, I think the hardreset fix is worthy including into -stable=
=2E
>  > It should be safe for -stable too, right?
>=20
> The hardreset fix was included in 2.6.27.5. I wanted it in 2.6.26-sta=
ble
> too, but that branch seems to have been closed now.

Ah, right, I was looking at 2.6.26.6 and thinking it was 2.6.27.6.  :-P

Thanks.

--
tejun


