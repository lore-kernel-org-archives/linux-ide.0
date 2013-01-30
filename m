From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ata: Fix DVD not dectected at some Haswell platforms
Date: Wed, 30 Jan 2013 16:29:19 +0400
Message-ID: <5109121F.1000205@mvista.com>
References: <1359566374-27286-1-git-send-email-youquan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:53272 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab3A3M3i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2013 07:29:38 -0500
Received: by mail-lb0-f172.google.com with SMTP id n8so2077337lbj.17
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2013 04:29:36 -0800 (PST)
In-Reply-To: <1359566374-27286-1-git-send-email-youquan.song@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: htejun@gmail.com, ming.lei@canonical.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com, jlee@suse.com, james.d.ralston@intel.com, Youquan Song <youquan.song@linux.intel.com>

Hello.

On 30-01-2013 21:19, Youquan Song wrote:

> There is a quirk patch 5e5a4f5d5a08c9c504fe956391ac3dae2c66556d fix the 4 ports
> IDE controller 32bit PIO mode.
> Recently, the problem was showed at Haswell platform which includes 2 ports
> IDE controller.

> So introduce a qurik patch to disable 32bit PIO at this IDE controller.

> Signed-off-by: Youquan Song <youquan.song@intel.com>
> ---
>   drivers/ata/ata_piix.c |   14 +++++++++++++-
>   1 files changed, 13 insertions(+), 1 deletions(-)

> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index ef773e1..1993e52 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
[...]
> @@ -326,7 +327,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
>   	/* SATA Controller IDE (Lynx Point) */
>   	{ 0x8086, 0x8c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
>   	/* SATA Controller IDE (Lynx Point) */
> -	{ 0x8086, 0x8c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> +	{ 0x8086, 0x8c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_snb },
>   	/* SATA Controller IDE (Lynx Point) */
>   	{ 0x8086, 0x8c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },

    Also, are you sure this one and the following Lynx Point controllers are 
not affected?

>   	/* SATA Controller IDE (Lynx Point-LP) */

MBR, Sergei

