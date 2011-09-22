From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/5] libsas: fix ->change_queue_{depth|type} for sata
 devices
Date: Wed, 21 Sep 2011 22:30:46 -0400
Message-ID: <4E7A9DD6.3040902@pobox.com>
References: <20110920220819.1094.12265.stgit@localhost6.localdomain6> <20110920221024.1094.58367.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:49068 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab1IVCat (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2011 22:30:49 -0400
In-Reply-To: <20110920221024.1094.58367.stgit@localhost6.localdomain6>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, JBottomley@parallels.com, Jack Wang <jack_wang@usish.com>, Tejun Heo <tj@kernel.org>, Xiangliang Yu <yuxiangl@marvell.com>, Mark Salyzyn <msalyzyn@us.xyratex.com>

On 09/20/2011 06:10 PM, Dan Williams wrote:
> Pass queue_depth change requests to libata, and prevent queue_type
> changes for ATA devices.
>
> Otherwise:
> 1/ we do not honor the libata specific restrictions on the queue depth
> 2/ libsas drivers that do not set sdev->tagged_supported are unable to
>     change the queue_depth of ata devices via sysfs
>
> Cc: Tejun Heo<tj@kernel.org>
> Cc: Xiangliang Yu<yuxiangl@marvell.com>
> Cc: Jack Wang<jack_wang@usish.com>
> Cc: Mark Salyzyn<msalyzyn@us.xyratex.com>
> Signed-off-by: Dan Williams<dan.j.williams@intel.com>
> ---
>   drivers/ata/libata-core.c           |    1 +
>   drivers/ata/libata-scsi.c           |   44 +++++++++++++++++++++++------------
>   drivers/scsi/libsas/sas_scsi_host.c |   11 ++++++++-
>   include/linux/libata.h              |    2 ++
>   4 files changed, 42 insertions(+), 16 deletions(-)

Acked-by: Jeff Garzik <jgarzik@redhat.com>



