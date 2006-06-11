From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git-patch] hotplug fix patches added
Date: Sun, 11 Jun 2006 09:51:37 -0400
Message-ID: <448C1FE9.6030003@pobox.com>
References: <448B7FFD.9050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52187 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751301AbWFKNvk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 09:51:40 -0400
In-Reply-To: <448B7FFD.9050507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello,
> 
> Two hotplug fix patches have been added to libata-tj #for-jeff.
> 
> * libata: add missing finish_wait() call in ata_port_wait_eh()
> * libata: cosmetic change in struct ata_port
> 
> The following two patches have been dropped as it hasn't been acked yet.
> 
> * ata_piix: fix ghost device probing by honoring PCS present bits[1]
> * libata: add ata_port->private_flags[2]
> 
> libata-tj #for-jeff is available at the following URL
> 
> http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=for-jeff
> git://htj.dyndns.org/libata-tj for-jeff

pulled


