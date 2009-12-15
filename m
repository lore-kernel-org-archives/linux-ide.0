From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA_SIL: Add a work-around for IXP4xx CPU.
Date: Tue, 15 Dec 2009 17:19:32 +0900
Message-ID: <4B274694.6020701@kernel.org>
References: <m3fx8m0vwh.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46815 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbZLOISk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Dec 2009 03:18:40 -0500
In-Reply-To: <m3fx8m0vwh.fsf@intrepid.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Hello,

On 11/11/2009 09:04 AM, Krzysztof Halasa wrote:
> IXP4xx CPUs can't read from 8 and 16-bit PCI MMIO registers, we have =
to read
> from normal IO regions instead.
>=20
> Tested on SIL3512, and specifically not tested on 4-port SIL3114.
>=20
> Signed-off-by: Krzysztof Ha=C5=82asa <khc@pm.waw.pl>

Hmmm... Given that there are some platforms which have problem with
mmio and sil3112/4 can do everything via io accesses, it would be nice
to generalize this so that there's CONFIG_SATA_SIL_NO_MMIO which is
selected by affected platforms.  Are you interested in doing it?

Thanks.

--=20
tejun
