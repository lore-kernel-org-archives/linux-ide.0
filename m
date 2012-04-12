From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RESEND PATCH v2] libata: disable runtime pm for hotpluggable
 port
Date: Thu, 12 Apr 2012 14:04:06 -0400
Message-ID: <4F871916.9080705@pobox.com>
References: <1334210174.11188.110.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:63207 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926Ab2DLSEJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2012 14:04:09 -0400
In-Reply-To: <1334210174.11188.110.camel@minggr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, jslaby@suse.cz, cwillu@cwillu.com, jackdachef@gmail.com, Sergei Shtylyov <sshtylyov@mvista.com>

On 04/12/2012 01:56 AM, Lin Ming wrote:
> Currently, hotplug doesn't work if port is already runtime suspended.
> For now, we simply disable runtime pm for hotpluggable port.
> Later, we should add runtime pm support for hotpluggable port too.
>
> Bug report:
> https://lkml.org/lkml/2012/2/19/70
>
> v2:
> - Use bit 2 and 3 for flags ATA_FLAG_EXTERNAL and ATA_FLAG_PLUGGABLE.
>
> TODO: add similar hotpluggable port check for controllers other than
> AHCI.
>
> Reported-and-tested-by: Jiri Slaby<jslaby@suse.cz>
> Reported-and-tested-by: cwillu@cwillu.com
> Reported-and-tested-by: jackdachef@gmail.com
> Signed-off-by: Lin Ming<ming.m.lin@intel.com>
> ---
>   drivers/ata/ahci.c             |    3 +++
>   drivers/ata/ahci.h             |    3 +++
>   drivers/ata/libahci.c          |   20 ++++++++++++++++++++
>   drivers/ata/libata-transport.c |    6 ++++--
>   include/linux/libata.h         |    2 ++
>   5 files changed, 32 insertions(+), 2 deletions(-)

The fundamental problem with this patch is that all SATA ports are 
hotpluggable... even the ones the firmware/silicon failed to mark as 
hotpluggable via AHCI's PORT_CMD_MPSP | PORT_CMD_HPCP
