From: Bernie Innocenti <bernie@codewiz.org>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Tue, 06 Oct 2009 21:40:18 -0400
Message-ID: <1254879618.1471.525.camel@giskard>
References: <1254546642.1438.135.camel@giskard> <4ACA6904.1060509@rtr.ca>
	 <4ACB3741.2030101@gmail.com> <1254852272.1471.172.camel@giskard>
	 <4ACBA33C.7090606@rtr.ca>  <1254873978.1471.463.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933884AbZJGBlB@vger.kernel.org>
In-Reply-To: <1254873978.1471.463.camel@giskard>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Harri Olin <harri.olin@gmail.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>
List-Id: linux-ide@vger.kernel.org

El Tue, 06-10-2009 a las 20:06 -0400, Bernie Innocenti escribi=F3:
> > The early revs of these chips did have a number of errata specific =
to PCI-X.
>=20
> I checked the revision (09) against the sata_mv source and I couldn't
> spot anything relevant to us.

NEWSFLASH: today we replaced the 4x500GB Seagate drives with 4x1.5TB
drives and reconstruction of the array has been running for 2h without =
a
glitch.

One interesting difference is that the 500GB drives were being
configured in 1.5Gbps SATA mode.  Another notable difference is the
sequential read speed: ~70MB/s vs ~130MB/s with the 1.5TB model.

Could the PCI bus errors be a red herring?

--=20
   // Bernie Innocenti - http://codewiz.org/
 \X/  Sugar Labs       - http://sugarlabs.org/
