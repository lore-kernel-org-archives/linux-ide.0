From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: s/ap->id/ap->print_id/g
Date: Tue, 20 Feb 2007 11:39:46 -0500
Message-ID: <45DB2452.9070603@garzik.org>
References: <20070220160651.GS1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44844 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030218AbXBTQjs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 11:39:48 -0500
In-Reply-To: <20070220160651.GS1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_port has two different id fields - id and port_no.  id is
> system-wide 1-based unique id for the port while port_no is 0-based
> host-wide port number.  The former is primarily used to identify the
> ATA port to the user in printk messages while the latter is used in
> various places in libata core and LLDs to index the port inside the
> host.
> 
> The two fields feel quite similar and sometimes ap->id is used in
> place of ap->port_no, which is very difficult to spot.  This patch
> renames ap->id to ap->print_id to reduce the possibility of such bugs.
> 
> Some printk messages are adjusted such that id string (ata%u[.%u])
> isn't printed twice and/or to use ata_*_printk() instead of hardcoded
> id format.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


