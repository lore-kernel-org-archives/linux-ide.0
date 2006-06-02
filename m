From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/6] The definition of ahci_port_standby() and	ahci_port_spinup()
Date: Fri, 02 Jun 2006 10:14:57 +0200
Message-ID: <447FF381.4060707@suse.de>
References: <1149234328.13451.56.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:1252 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751304AbWFBIO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2006 04:14:59 -0400
In-Reply-To: <1149234328.13451.56.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Put port power management[1], staggered-spinup[2], cold presence
> detection[3] related operations during the power state transition int=
o
> ahci_port_standby() and ahci_port_spinup().
>=20
> In particular ahci_port_standby() does the [1] and [2] when power tra=
nsits
> to a lower level; ahci_port_spinup() does [1], [2] and [3] when power
> transits to a higher level.
>=20
Did you actually test with staggered-spinup and/or cold-presence
detection? I just added them per spec but never got a chance to test
them here.

And: it might be an idea to rename the HOST_CAP bits to be consistent
with those printed during initialisation. It's bad enough as it is (ie
the spec uses different abbrevs than the implementation), but we should
try to be consistent within the implementation.
I would rename them to HOST_CAP_STAG and HOST_CAP_SLUM.

Add slumber mode: libata-core used to issue a port reset with an
implicit SLUMBER/PARTIAL mode disable. So after a reset we might not be
able to put the device into SLUMBER mode even if supported.
What was the reasoning for this?

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de
