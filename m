From: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Fri, 30 May 2008 12:43:39 +0200
Message-ID: <200805301243.39751.volker.armin.hemmann@tu-clausthal.de>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200805291654.03617.volker.armin.hemmann@tu-clausthal.de> <483F804F.1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:54413 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbYE3Knn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 May 2008 06:43:43 -0400
In-Reply-To: <483F804F.1@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Peer Chen <pchen@nvidia.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

On Freitag, 30. Mai 2008, Tejun Heo wrote:
> Hello,
>
> Hemmann, Volker Armin wrote:
> > -AHCI+nomsi: boots fine. Works fine. But: I still can not enable nc=
q
> > -AHCI+msi: the usual. No harddisks found, waiting for the timeouts,=
 then
> > kernel panic because of missing root.
> >
> > -NON-RAID/IDE+msi: works fine. No delays. No NCQ (not surprising si=
nce
> > mobos handbook says that AHCI mode is required).
> > -NON-RAID/IDE+nomsi: see above.
>
> So, sans NCQ, the only remaining issue is MSI, right?  Peer Chen, ple=
ase
> lemme know which controllers are affected by this MSI problem and whe=
re
> the problem lies.

this is correct.

> The controller is not reporting NCQ capability in its cap register
> (flags: line contains ncq if the controller is), so NCQ is not enable=
d.

ah, I thought all AHCI chipsets support NCQ (and the board's handbook l=
ists it=20
as feature) thanks for the explanation.

Gl=FCck Auf,
Volker
