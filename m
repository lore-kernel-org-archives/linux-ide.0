From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Fri, 09 Aug 2013 18:26:16 +0400
Message-ID: <5204FC08.6070505@cogentembedded.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:47950 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030588Ab3HIO0J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:26:09 -0400
Received: by mail-lb0-f172.google.com with SMTP id o7so3261477lbv.3
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:26:07 -0700 (PDT)
In-Reply-To: <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Hello.

On 08/09/2013 08:49 AM, Marc C wrote:

> From: Marc Carino <marc.ceeeee@gmail.com>

> SATA 3.1 added an "auxiliary" field to the host-to-device FIS.

> Since there is no analog between the new field and the ATA
> taskfile, a new element was added to 'struct ata_queued_cmd."

> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> ---
>   drivers/ata/acard-ahci.c  |  2 +-
>   drivers/ata/libahci.c     |  2 +-
>   drivers/ata/libata-core.c | 29 +++++++++++++++++++++++++++++
>   drivers/ata/sata_fsl.c    |  2 +-
>   drivers/ata/sata_mv.c     |  2 +-
>   drivers/ata/sata_qstor.c  |  2 +-
>   drivers/ata/sata_sil24.c  |  2 +-
>   include/linux/libata.h    |  4 ++++
>   8 files changed, 39 insertions(+), 6 deletions(-)

    Looks like you missed drivers/scsi/libsas/sas_ata.c...

WBR, Sergei

