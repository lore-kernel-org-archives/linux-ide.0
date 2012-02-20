From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] ahci: add AHCI_HFLAG_STRICT_SPEC host flag
Date: Mon, 20 Feb 2012 13:23:23 -0800
Message-ID: <20120220212323.GE3538@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1329768563-13715-1-git-send-email-computersforpeace@gmail.com>
 <1329768563-13715-2-git-send-email-computersforpeace@gmail.com>
 <20120220205115.GA3538@dhcp-172-17-108-109.mtv.corp.google.com>
 <CAN8TOE8Jgje7kjpZ-bsoObs-kbYYjwwDVEeN-K7ExMq5NuR4tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53302 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab2BTVXc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2012 16:23:32 -0500
Content-Disposition: inline
In-Reply-To: <CAN8TOE8Jgje7kjpZ-bsoObs-kbYYjwwDVEeN-K7ExMq5NuR4tQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Lin Ming <ming.m.lin@intel.com>, Norbert Preining <preining@logic.at>, "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Valdis Kletnieks <valdis.kletnieks@vt.edu>, "Rafael J . Wysocki" <rjw@sisk.pl>

On Mon, Feb 20, 2012 at 01:16:27PM -0800, Brian Norris wrote:
> On Mon, Feb 20, 2012 at 12:51 PM, Tejun Heo <tj@kernel.org> wrote:
> > Overall the patchset looks good but
> >
> > On Mon, Feb 20, 2012 at 12:09:21PM -0800, Brian Norris wrote:
> >> + =A0 =A0 AHCI_HFLAG_STRICT_SPEC =A0 =A0 =A0 =A0 =A0=3D (1 << 15),=
 /* strict AHCI spec */
> >
> > can you please use something more specific? =A0e.g. something like
> > SKIP_ENGINE_ON_PORT_START and then explain what the flag is about i=
n
> > the comment?
>=20
> So you want AHCI_HFLAG_SKIP_ENGINE_ON_PORT_START? That seems
> excessively long... how about AHCI_HFLAG_DELAY_ENGINE? (since it
> pushes the start engine call back to the error-handling stage)

Ooh, yeah, that seems better.  I'm fine with any name which ties it to
engine behavior on port start.

Thanks.

--=20
tejun
