From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ICH6R support 2.4.20
Date: Tue, 26 Jul 2005 22:42:04 -0400
Message-ID: <42E6F47C.4070001@pobox.com>
References: <42E6EBA1.8080902@packetdesign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:20669 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262359AbVG0CmR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2005 22:42:17 -0400
In-Reply-To: <42E6EBA1.8080902@packetdesign.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Siddharth Taneja <staneja@packetdesign.com>
Cc: linux-ide@vger.kernel.org

Siddharth Taneja wrote:
> Hi,
> 
> I am trying to port our software system (uses a 2.4.20 kernel) to a new 
> platform which has a ICH6R controller. Due to some reasons we cannot 
> update our kernel to a more recent one (probably 2.4.27) which has 
> libata support in it. I can successfully patch the kernel (after some 
> modifications) with the 2.4.26-libata patch and get the system up and 
> running using the drivers/ide code. But I cannot seem to get the 
> ata_piix (scsi layer) working (does not patch cleanly). Is there a patch 
> available for 2.4.20 that can get the ICH6R support. Or is there a way 
> to get the dma mode enabled with the drivers/ide code?

Turn off combined mode, and PATA DMA will start working.

	Jeff



