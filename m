From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ahci.c
Date: Wed, 11 Jun 2008 22:50:25 -0400
Message-ID: <48508EF1.8000304@pobox.com>
References: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45463 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbYFLCua (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jun 2008 22:50:30 -0400
In-Reply-To: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dunneil <dunneil@live.cn>
Cc: linux-ide@vger.kernel.org

dunneil wrote:
> hi,
>  
>   My hardware is AHCI SATA controller with FPGA-based PCIE board.My 
> kernel is 2.6.20.7. after insmod ahci.ko, i run lspci -xxxxvvvv 
> command.but,it seems that it doesn't set the BUS master enable bit of 
> PCIE header command register.plz check my header content.
>  
>   But,i run Pcitree software at windows.The BUS master enable is 
> observed to be set,and that i can read out a part of sata register value.
>  
>   how to debug this issue?

ahci.c calls pci_set_master() to enable the BusMaster bit.

	Jeff





