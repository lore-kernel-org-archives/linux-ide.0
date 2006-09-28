From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] too late: updated version of the ACPI patches
Date: Thu, 28 Sep 2006 10:05:47 -0700
Message-ID: <20060928100547.a284c0eb.kristen.c.accardi@intel.com>
References: <451B8A05.5080002@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4216 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751943AbWI1RGI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 13:06:08 -0400
In-Reply-To: <451B8A05.5080002@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org

On Thu, 28 Sep 2006 10:38:29 +0200
Hannes Reinecke <hare@suse.de> wrote:

> Hi Jeff,
>=20
> argl. Appearently I'm in Yeltsin mode.
>=20
> Anyway: I'm also have finished an updated version of the ACPI patches=
=2E
> They are also based upon the patches by Randy Dunlap but with some=20
> improvements:

Hey,
I don't care who gets this stuff in, I just want it done with :).
I'm going to go ahead and make the changes to my patches that Jeff=20
suggested yesterday, but I'm also glad to help review your patches. =20
But having looked at your attachment I feel like I'm missing something.=
 =20
Was there more than this?  I don't see the patch that has libata-acpi.c=
 in it.

>=20
> - Omit the namespace walk for SATA devices. We can really trust the A=
CPI=20
> layer to find out the correct device. If not the ACPI is buggered any=
way=20
> and we shouldn't even try to continue.

Not sure about this one - how does this work for devices that may not
be present at boot time?  Normally this is something we have to walk
namespace for in order to discover -- at least with removable bay
devices.

> - Make the control over the ACPI execution more finegrained as some=20
> methods (most notably _GTF) are downright disastrous on PATA devices,=
=20
> whereas you really want to call _GTM / _STM on these to have them=20
> properly resumed after suspend to RAM.
> - Only export the symbols we really have to :-)
> - Proper integration with the new EH code. This is actually an error =
in=20
> the patch by Kristen; for new-style EH the ACPI functions will never =
be=20
> called :-(
>=20
> If you consider this a duplicate I'm happy to rebase my patch on top =
of=20
> Kristens.
>=20
> Comments etc are welcome.
>=20
> Cheers,
>=20
> Hannes
> --=20
> Dr. Hannes Reinecke			hare@suse.de
> SuSE Linux Products GmbH		S390 & zSeries
> Maxfeldstra=DFe 5				+49 911 74053 688
> 90409 N=FCrnberg				http://www.suse.de
>=20
