From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 13/14] libata-hp-prep: add prereset() method and
	implement ata_std_prereset()
Date: Tue, 23 May 2006 23:29:32 +0100
Message-ID: <1148423372.25255.130.camel@localhost.localdomain>
References: <11480445853715-git-send-email-htejun@gmail.com>
	 <446DE24E.4070501@pobox.com>  <44731FD4.6050008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26763 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932198AbWEWWQw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 18:16:52 -0400
In-Reply-To: <44731FD4.6050008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, mlord@pobox.com, albertcc@tw.ibm.com, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

On Maw, 2006-05-23 at 07:44 -0700, Tejun Heo wrote:
> Waiting for spinup is common operation for both PATA and SATA although I 
> don't know how many PATA controllers support hotplug.

Most do, but few vendors ship the required extra buffers for many of the
chips. Unfortunately it means we have to add code for lots of chips each
with few hot/warmplug users 8(


> ata_port_offline() applies to both PATA and SATA.  It's just that the 
> current implmentation always returns 0 for PATA.  Well, I don't know. 
> Maybe we should rename all those to sata_*() and rename them again when 
> actual PATA support is implemented.
> 

What is ata_port_offline() intended to do ?

