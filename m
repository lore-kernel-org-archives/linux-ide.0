From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: handle pci_enable_device() failure while resuming
Date: Tue, 09 Jan 2007 05:42:45 -0500
Message-ID: <45A371A5.9080900@pobox.com>
References: <20061226103950.GA10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33648 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbXAIKmr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Jan 2007 05:42:47 -0500
In-Reply-To: <20061226103950.GA10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Handle pci_enable_device() failure while resuming.  This patch kills
> the "ignoring return value of 'pci_enable_device'" warning message and
> propagates __must_check through ata_pci_device_do_resume().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c        |    4 +++-
>  drivers/ata/libata-core.c |   22 +++++++++++++++++-----
>  drivers/ata/sata_sil.c    |    6 +++++-
>  drivers/ata/sata_sil24.c  |    5 ++++-
>  include/linux/libata.h    |    2 +-
>  5 files changed, 30 insertions(+), 9 deletions(-)

applied


