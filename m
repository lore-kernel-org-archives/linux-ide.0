From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI UDMA - first in Linux
Date: 15 May 2004 07:27:45 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084627665.3079.23.camel@patibmrh9>
References: <1084563800.8752.53.camel@patibmrh9><40A52683.8050604@pobox.com>
	<1084565990.3084.36.camel@patibmrh9>  <40A52DA9.6040200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:4567 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262388AbUEON2J
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 09:28:09 -0400
In-Reply-To: <40A52DA9.6040200@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> > Do we all agree SATA ATAPI UDMA is missing
> > from Linux-2.6.6 `make defconfig`?
> 
> No.  No need for new options, if you are using
> the IDE driver.
> 
> Once libata ATAPI support is working, it can
> simply be turned on.  No need for a config
> option there, either.
> 
> > Can any of us suggest other .config options
> > to try?
> 
> CONFIG_...=y
> # CONFIG_... is not set
> ...

I will focus on those CONFIG, thank you.

Possibly the CONFIG_SCSI_SATA is key.  Me the newbie, by living in fear
near `make defconfig` I got the =y you quote, except:

# CONFIG_IDEDISK_STROKE is not set

But the =n you quote I do not yet have, instead I have:
 
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_SCSI_SATA=y

My records tell me 2.6.6 `make defconfig` gave me the =y and =n you
quote except:

# CONFIG_IDEDISK_STROKE is not set
# CONFIG_IDE_TASK_IOCTL is not set

CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_SCSI_SATA=y

"Possibly the CONFIG_SCSI_SATA is key."

Pat LaVarre

--- ~/bin/sataconfig
#!/bin/bash

# Translated to bash from the English of:
#
# List:       linux-ide
# Subject:    Re: SATA ATAPI UDMA - first in Linux
# Date:       2004-05-14 20:35:53
# http://marc.theaimsgroup.com/?l=linux-ide&m=108456699805023

y="CONFIG_BLK_DEV_IDEDISK"
y="$y|CONFIG_IDEDISK_STROKE"
y="$y|CONFIG_BLK_DEV_IDECD"
y="$y|CONFIG_IDE_TASK_IOCTL"
y="$y|CONFIG_IDE_TASKFILE_IO"
y="$y|CONFIG_BLK_DEV_IDEPCI"
y="$y|CONFIG_IDEPCI_SHARE_IRQ"
y="$y|CONFIG_BLK_DEV_GENERIC"
y="$y|CONFIG_BLK_DEV_IDEDMA_PCI"
y="$y|CONFIG_IDEDMA_PCI_AUTO"
y="$y|CONFIG_BLK_DEV_ADMA"

n="CONFIG_IDEDISK_MULTI_MODE"
n="$n|CONFIG_BLK_DEV_IDETAPE"
n="$n|CONFIG_BLK_DEV_IDEFLOPPY"
n="$n|CONFIG_BLK_DEV_IDESCSI"
n="$n|CONFIG_IDE_GENERIC"
n="$n|CONFIG_BLK_DEV_CMD640"
n="$n|CONFIG_BLK_DEV_OFFBOARD"
n="$n|CONFIG_BLK_DEV_OPTI621"
n="$n|CONFIG_BLK_DEV_RZ1000"
n="$n|CONFIG_BLK_DEV_IDEDMA_FORCED"
n="$n|CONFIG_IDEDMA_ONLYDISK"
n="$n|CONFIG_SCSI_SATA"

echo ''
echo '# =y recommended for SATA ATAPI UDMA before lk 2.6.7:'
egrep "$y" .config

echo ''
echo '# =n recommended for SATA ATAPI UDMA before lk 2.6.7:'
egrep "$n" .config


