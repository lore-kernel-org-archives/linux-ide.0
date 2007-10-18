From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v3] drivers/ata: add support to Freescale 3.0Gbps SATA
 Controller
Date: Wed, 17 Oct 2007 20:57:50 -0400
Message-ID: <4716AF8E.5030509@pobox.com>
References: <1192539518-6642-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33971 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933260AbXJRA5x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 20:57:53 -0400
In-Reply-To: <1192539518-6642-1-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: linux-ide@vger.kernel.org, arnd@arndb.de, Ashish Kalra <ashish.kalra@freescale.com>

Li Yang wrote:
> This patch adds support for Freescale 3.0Gbps SATA Controller supporting
> Native Command Queueing(NCQ), device hotplug, and ATAPI.  This controller
> can be found on MPC8315 and MPC8378.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Address comments from Arnd Bergmann.
> 
>  drivers/ata/Kconfig    |    9 +
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_fsl.c | 1490 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1500 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_fsl.c

applied


