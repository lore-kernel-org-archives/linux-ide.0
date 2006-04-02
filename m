From: Mark Lord <lkml@rtr.ca>
Subject: Re: sata_mv: module reloading doesn't work
Date: Sun, 02 Apr 2006 12:05:46 -0400
Message-ID: <442FF65A.6020209@rtr.ca>
References: <20060402155647.GB20270@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:50606 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751481AbWDBQGG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 12:06:06 -0400
In-Reply-To: <20060402155647.GB20270@localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Dan Aloni wrote:
> Hello,
> 
> I'm testing the sata_mv driver to see whether reloading (rmmod 
> - insmod) works, and it seems something is broken there. The
> first insmod goes okay - however all the insmods that follow
> emit error=0x01 { AddrMarkNotFound } and status=0x50 { DriveReady 
> SeekComplete } from all the drives.
> 
> I've enabled DPRINTK and fixed a crash involved with register
> dumping (posted in my previous mail).
> 
> I hope these messages are sufficient, I can provide more 
> information if needed.

What kernel?  Any patches applied to sata_mv.c ??
