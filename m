From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 7/7] libata: Add 32bit PIO support
Date: Mon, 05 Jan 2009 19:06:26 -0600
Message-ID: <4962AE92.5060401@shaw.ca>
References: <20090105141102.28189.44312.stgit@localhost.localdomain> <20090105141619.28189.6174.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:34777 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbZAFBG3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 20:06:29 -0500
In-Reply-To: <20090105141619.28189.6174.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> This matters for some controllers and in one or two cases almost doubles
> PIO performance. Add a bmdma32 operations set we can inherit and activate
> it for some controllers
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
> 
>  drivers/ata/ata_piix.c    |    2 +-
>  drivers/ata/libata-sff.c  |   53 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/pata_ali.c    |    6 +++--
>  drivers/ata/pata_amd.c    |    4 ++-
>  drivers/ata/pata_mpiix.c  |    3 ++-
>  drivers/ata/pata_sil680.c |    4 ++-
>  include/linux/libata.h    |    3 +++
>  7 files changed, 66 insertions(+), 9 deletions(-)

This can likely be enabled for more controllers (presumably all the 
SFF-based SATA controllers as well as any other PATA that couldn't be on 
a physical ISA bus). This is a start though.

Don't some of the VLB controller drivers have their own private 32-bit 
PIO implementation? Those should likely be updated to use this support.
