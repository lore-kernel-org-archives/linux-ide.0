From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: add host_set->next for legacy two host_sets case,
 take #3
Date: Mon, 12 Jun 2006 10:24:10 -0400
Message-ID: <448D790A.4070308@pobox.com>
References: <20060612051727.GD9166@htj.dyndns.org> <448D0FF9.1080605@pobox.com> <20060612101419.GB5751@htj.dyndns.org> <448D6DBF.9010604@pobox.com> <20060612140538.GA3892@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35732 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752013AbWFLOYO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2006 10:24:14 -0400
In-Reply-To: <20060612140538.GA3892@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

Tejun Heo wrote:
> For a legacy ATA controller, libata registers two separate host sets.
> There was no connection between the two hosts making it impossible to
> traverse all ports related to the controller.  This patch adds
> host_set->next which points to the second host_set and makes
> ata_pci_remove_one() remove all associated host_sets.
> 
> * On device removal, all ports hanging off the device are properly
>   detached.  Prior to this patch, ports on the first host_set weren't
>   detached casuing oops on driver unloading.
> 
> * On device removal, both host_sets are properly freed
> 
> This will also be used by new power management code to suspend and
> resume all ports of a controller.  host_set/port representation will
> be improved to handle legacy controllers better and this host_set
> linking will go away with it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


