From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream 3/3 REGENERATED] libata: implement
 and use ata_port_desc() to report port configuration
Date: Fri, 31 Aug 2007 05:35:46 -0400
Message-ID: <46D7E0F2.1020100@garzik.org>
References: <20070730052303.GH22374@htj.dyndns.org> <20070730052415.GI22374@htj.dyndns.org> <20070730052527.GJ22374@htj.dyndns.org> <46C2BDEE.7060705@garzik.org> <20070818041455.GB8590@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45127 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbXHaJfs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 05:35:48 -0400
In-Reply-To: <20070818041455.GB8590@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Currently, port configuration reporting has the following problems.
> 
> * iomapped address is reported instead of raw address
> * report contains irrelevant fields or lacks necessary fields for
>   non-SFF controllers.
> * host->irq/irq2 are there just for reporting and hacky.
> 
> This patch implements and uses ata_port_desc() and
> ata_port_pbar_desc().  ata_port_desc() is almost identical to
> ata_ehi_push_desc() except that it takes @ap instead of @ehi, has no
> locking requirement, can only be used during host initialization and "
> " is used as separator instead of ", ".  ata_port_pbar_desc() is a
> helper to ease reporting of a PCI BAR or an offsetted address into it.
> 
> LLD pushes whatever description it wants using the above two
> functions.  The accumulated description is printed on host
> registration after "[S/P]ATA max MAX_XFERMODE ".
> 
> SFF init helpers and ata_host_activate() automatically add
> descriptions for addresses and irq respectively, so only LLDs which
> isn't standard SFF need to add custom descriptions.  In many cases,
> such controllers need to report different things anyway.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Regenerated against the current #upstream (41b135c7).

applied


