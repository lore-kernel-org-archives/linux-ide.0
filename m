From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.24] ahci: RAID mode SATA patch for Intel ICH10 DeviceID's
Date: Tue, 29 Jan 2008 12:13:26 -0500
Message-ID: <479F5EB6.5030406@pobox.com>
References: <200801281734.14535.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35006 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500AbYA2RN3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jan 2008 12:13:29 -0500
In-Reply-To: <200801281734.14535.jason.d.gaston@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jason Gaston wrote:
> This patch adds the Intel ICH10 SATA RAID Controllers DeviceID's.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.24/drivers/ata/ahci.c.orig	2008-01-24 14:58:37.000000000 -0800
> +++ linux-2.6.24/drivers/ata/ahci.c	2008-01-28 14:58:22.000000000 -0800
> @@ -475,6 +475,8 @@
>  	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
>  	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
>  	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
> +	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
> +	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */

applied


