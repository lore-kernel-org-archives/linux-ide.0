From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] ata_piix: IDE-mode SATA patch for Intel DH89xxCC
 DeviceIDs
Date: Thu, 12 Apr 2012 15:58:29 -0400
Message-ID: <4F8733E5.7010403@pobox.com>
References: <1329849926-7235-1-git-send-email-seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60825 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab2DLT6c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2012 15:58:32 -0400
In-Reply-To: <1329849926-7235-1-git-send-email-seth.heasley@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: --cc@maroon.pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, James Ralston <james.d.ralston@intel.com>

On 02/21/2012 01:45 PM, Seth Heasley wrote:
> This patch adds the IDE-mode SATA DeviceIDs for the Intel DH89xxCC PCH.
>
> Signed-off-by: Seth Heasley<seth.heasley@intel.com>
> ---
>   drivers/ata/ata_piix.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index fdf27b9..d0a9599 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -321,6 +321,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
>   	{ 0x8086, 0x1e08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>   	/* SATA Controller IDE (Panther Point) */
>   	{ 0x8086, 0x1e09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> +	/* SATA Controller IDE (DH89xxCC) */
> +	{ 0x8086, 0x2326, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },

applied



