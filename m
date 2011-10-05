From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ata_piix: make DVD Drive recognisable on systems with
 Intel Sandybridge chipsets(v1)
Date: Wed, 05 Oct 2011 13:45:08 +0400
Message-ID: <4E8C2724.7030608@mvista.com>
References: <1317433412-15963-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43350 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933732Ab1JEJqB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2011 05:46:01 -0400
Received: by wwn22 with SMTP id 22so6106337wwn.1
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2011 02:46:00 -0700 (PDT)
In-Reply-To: <1317433412-15963-1-git-send-email-ming.lei@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ming.lei@canonical.com
Cc: htejun@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, seth.heasley@intel.com, Alan Cox <alan@linux.intel.com>

On 01.10.2011 5:43, ming.lei@canonical.com wrote:

> From: Ming Lei <ming.lei@canonical.com>

> This quirk patch fixes one kind of bug inside some Intel Sandybridge
> chipsets, see reports from

>         https://bugzilla.kernel.org/show_bug.cgi?id=40592.

> Many guys also have reported the problem before:

> 	https://bugs.launchpad.net/bugs/737388
> 	https://bugs.launchpad.net/bugs/794642
> 	https://bugs.launchpad.net/bugs/782389
> 	......

> With help from Tejun, the problem is found to be caused by 32bit PIO
> mode, so introduce the quirk patch to disable 32bit PIO on SATA piix
> for some Sandybridge CPT chipsets.

> Seth also tested the patch on all five affected chipsets
> (pci device ID: 0x1c00, 0x1c01, 0x1d00, 0x1e00, 0x1e01), and found
> the patch does fix the problem.

> Tested-by: Heasley, Seth<seth.heasley@intel.com>
> Cc: Alan Cox<alan@linux.intel.com>
> Signed-off-by: Ming Lei<ming.lei@canonical.com>
> Signed-off-by: Tejun Heo<htejun@gmail.com>
> ---
>   drivers/ata/ata_piix.c |   37 ++++++++++++++++++++++++++++++++-----
>   include/linux/libata.h |    1 +
>   2 files changed, 33 insertions(+), 5 deletions(-)

> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 43107e9..70095be 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -113,6 +113,8 @@ enum {
>   	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
>   	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
>
> +	PIIX_FLAG_PIO16		= ATA_FLAG_PIO16,

    It's not clear why are you declaring a ganeric flag and then add a local 
name for it...

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index efd6f98..dc68de5 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -207,6 +207,7 @@ enum {
>   	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
>   					      * led */
>   	ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
> +	ATA_FLAG_PIO16		= (1 << 24),  /*16bit PIO */

    Please, fix the formatting. Or better totally remove this.

WBR, Sergei
