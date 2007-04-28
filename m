From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/13] ahci: consolidate common port flags
Date: Sat, 28 Apr 2007 14:51:55 -0400
Message-ID: <463397CB.6020705@garzik.org>
References: <1177263665394-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53439 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbXD1SwG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 14:52:06 -0400
In-Reply-To: <1177263665394-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Consolidate common port flags into AHCI_FLAG_COMMON.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c |   29 ++++++++++-------------------
>  1 files changed, 10 insertions(+), 19 deletions(-)

applied patches 1-2


