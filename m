From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] ata/sata_sil24: MSI support, disabled by default
Date: Mon, 16 Nov 2009 22:19:44 -0500
Message-ID: <4B021650.6050708@garzik.org>
References: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50969 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200AbZKQDTk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2009 22:19:40 -0500
In-Reply-To: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vivek Mahajan <vivek.mahajan@freescale.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On 11/16/2009 01:19 AM, Vivek Mahajan wrote:
> The following patch adds MSI support. Some platforms
> may have broken MSI, so those are defaulted to use
> legacy PCI interrupts.
>
> Signed-off-by: Vivek Mahajan<vivek.mahajan@freescale.com>
> ---
>   drivers/ata/sata_sil24.c |    9 +++++++++
>   1 files changed, 9 insertions(+), 0 deletions(-)

applied


