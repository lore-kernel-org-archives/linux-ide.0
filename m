From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ata_piix: make DVD Drive recognisable on systems with
 Intel Sandybridge chipsets(v2)
Date: Fri, 07 Oct 2011 14:34:28 +0400
Message-ID: <4E8ED5B4.5040300@mvista.com>
References: <1317959422-12860-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41051 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759820Ab1JGKfW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2011 06:35:22 -0400
Received: by wwf22 with SMTP id 22so5703849wwf.1
        for <linux-ide@vger.kernel.org>; Fri, 07 Oct 2011 03:35:21 -0700 (PDT)
In-Reply-To: <1317959422-12860-1-git-send-email-ming.lei@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ming.lei@canonical.com
Cc: htejun@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, seth.heasley@intel.com, Alan Cox <alan@linux.intel.com>

Hello.

On 07-10-2011 7:50, ming.lei@canonical.com wrote:

> From: Ming Lei<ming.lei@canonical.com>

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
> Acked-by: Tejun Heo<htejun@gmail.com>
> ---
> v2: avoid to use global flag
> ---
>   drivers/ata/ata_piix.c |   37 ++++++++++++++++++++++++++++++++-----
>   1 files changed, 32 insertions(+), 5 deletions(-)

> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 43107e9..cc431d6 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -113,6 +113,8 @@ enum {
>   	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
>   	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
>
> +	PIIX_FLAG_PIO16		= (1<<  30), /*support 16bit PIO only*/
> +

    Why didn't you declare it with the other PIIX_FLAG_* values?

WBR, Sergei
