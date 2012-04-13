From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [RESEND PATCH v2] libata: disable runtime pm for hotpluggable
 port
Date: Fri, 13 Apr 2012 09:24:07 +0800
Message-ID: <1334280247.11188.115.camel@minggr>
References: <1334210174.11188.110.camel@minggr> <4F871916.9080705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59443 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789Ab2DMBYK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Apr 2012 21:24:10 -0400
In-Reply-To: <4F871916.9080705@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, jslaby@suse.cz, cwillu@cwillu.com, jackdachef@gmail.com, Sergei Shtylyov <sshtylyov@mvista.com>

On Thu, 2012-04-12 at 14:04 -0400, Jeff Garzik wrote:
> On 04/12/2012 01:56 AM, Lin Ming wrote:
> > Currently, hotplug doesn't work if port is already runtime suspended.
> > For now, we simply disable runtime pm for hotpluggable port.
> > Later, we should add runtime pm support for hotpluggable port too.
> >
> > Bug report:
> > https://lkml.org/lkml/2012/2/19/70
> >
> > v2:
> > - Use bit 2 and 3 for flags ATA_FLAG_EXTERNAL and ATA_FLAG_PLUGGABLE.
> >
> > TODO: add similar hotpluggable port check for controllers other than
> > AHCI.
> >
> > Reported-and-tested-by: Jiri Slaby<jslaby@suse.cz>
> > Reported-and-tested-by: cwillu@cwillu.com
> > Reported-and-tested-by: jackdachef@gmail.com
> > Signed-off-by: Lin Ming<ming.m.lin@intel.com>
> > ---
> >   drivers/ata/ahci.c             |    3 +++
> >   drivers/ata/ahci.h             |    3 +++
> >   drivers/ata/libahci.c          |   20 ++++++++++++++++++++
> >   drivers/ata/libata-transport.c |    6 ++++--
> >   include/linux/libata.h         |    2 ++
> >   5 files changed, 32 insertions(+), 2 deletions(-)
> 
> The fundamental problem with this patch is that all SATA ports are 
> hotpluggable... even the ones the firmware/silicon failed to mark as 
> hotpluggable via AHCI's PORT_CMD_MPSP | PORT_CMD_HPCP

So the acceptable solution is to add runtime pm support for hotpluggable
port.

I'll send new patches.

Thanks,
Lin Ming


