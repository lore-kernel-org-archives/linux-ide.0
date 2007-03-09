From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 03/12] libata: separate out ata_host_alloc() and ata_host_attach()
Date: Fri, 09 Mar 2007 10:34:52 -0500
Message-ID: <45F17E9C.3030104@garzik.org>
References: <11734389353424-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57076 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993117AbXCIPez (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 10:34:55 -0500
In-Reply-To: <11734389353424-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Reorganize ata_host_alloc() and its subroutines into the following
> three functions.
> 
> * ata_host_alloc() : allocates host and its attached ports.  shost is
>   not attached automatically.
> 
> * ata_scsi_add_hosts() : allocates and adds shosts associated with an
>   ATA host.  Used by ata_host_attach().
> 
> * ata_host_attach() : takes a fully initialized ata_host structure and
>   registers it to libata layer and probes it.

I think it's more common in Linux to use foo_register than foo_attach. 
attach is more a BSD-ism :)

ACK patches 2-3, modulo the naming comment



