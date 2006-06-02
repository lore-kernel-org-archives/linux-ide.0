From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 6/6] Implement the AHCI suspend/resume
Date: Fri, 02 Jun 2006 10:21:34 +0200
Message-ID: <447FF50E.4060609@suse.de>
References: <1149234379.13451.59.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:57316 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751034AbWFBIVg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2006 04:21:36 -0400
In-Reply-To: <1149234379.13451.59.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

zhao, forrest wrote:
> This patch implements the AHCI suspend/resume.
> It puts the port suspend/resume operations in=20
> ahci_pci_device_suspend/resume(), which is in conformance with
> Jeff's idea of host<->bus<->device suspend/resume sequence.
>=20
>=20
> Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>
>=20
There is one quirky bit in here: we have to enable interrupts for the
_adapter_ after all _devices_ have been re-initialized.
This breaks the host<->bus<->device initialization sequence.
Is there any chance libata can add some hooks for that sort of thing?
The current approach (using a device map and run the host initialisatio=
n
after the last device is done) is a bit hackish.
I'd rather like to see the upper layers being able to deal with such
devices. But until then:

Signed-off-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de
