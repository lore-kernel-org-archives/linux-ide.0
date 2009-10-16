From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] ata: rename AMD SB900 into Hudson-2
Date: Fri, 16 Oct 2009 06:26:30 -0400
Message-ID: <4AD84A56.6000701@pobox.com>
References: <1255403640.3625.6.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44565 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757525AbZJPK1J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Oct 2009 06:27:09 -0400
In-Reply-To: <1255403640.3625.6.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 10/12/2009 11:14 PM, Shane Huang wrote:
> This patch renames the code name SB900 into Hudson-2
>
> Signed-off-by: Shane Huang<shane.huang@amd.com>
> ---
>   drivers/ata/ahci.c        |    2 +-
>   drivers/ata/pata_atiixp.c |    2 +-
>   drivers/ide/atiixp.c      |    2 +-
>   drivers/pci/quirks.c      |    6 +++---
>   include/linux/pci_ids.h   |    6 ++----
>   5 files changed, 8 insertions(+), 10 deletions(-)

applied


