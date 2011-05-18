From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata: ahci_start_engine compliant to AHCI spec"
Date: Wed, 18 May 2011 21:44:37 +0200
Message-ID: <201105182144.37713.rjw@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost> <BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36977 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730Ab1ERTn6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 May 2011 15:43:58 -0400
In-Reply-To: <BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jian Peng <jipeng2005@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Michael Leun <lkml20100708@newton.leun.net>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Wednesday, May 18, 2011, Jian Peng wrote:
> Hi, Valdis/Rafael/Michael,
> 
> Could you help me test the following change?
> 
> After reverting 81ca7e4, add 5ms delay as follow since that seems also
> fixing the issue on my SATA host controller that requires 81ca7e4.
> 
> In drivers/ata/libahci.c, inside ahci_hardreset() function,
> 
> 
> 1333 <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1333>
> ahci_start_engine
> <http://lxr.linux.no/linux+*/+code=ahci_start_engine>(ap
> <http://lxr.linux.no/linux+*/+code=ap>);
> 
>             msleep(5);1334
> <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1334>1335
> <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1335>        if
> (online <http://lxr.linux.no/linux+*/+code=online>)1336
> <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1336>
>   *class <http://lxr.linux.no/linux+*/+code=class> = ahci_dev_classify
> <http://lxr.linux.no/linux+*/+code=ahci_dev_classify>(ap
> <http://lxr.linux.no/linux+*/+code=ap>);
> 
> Since my host controller requires time to switch internal state to be ready.
> Please let me know your testing result.

Could you simply post a patch?

Rafael
