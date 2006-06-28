From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: add host_set->next for legacy two host_sets case,
 take #3
Date: Wed, 28 Jun 2006 18:27:05 +0800
Message-ID: <44A25979.3020709@tw.ibm.com>
References: <20060612051727.GD9166@htj.dyndns.org> <448D0FF9.1080605@pobox.com> <20060612101419.GB5751@htj.dyndns.org> <448D6DBF.9010604@pobox.com> <20060612140538.GA3892@htj.dyndns.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:53482 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932504AbWF1K1N
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 06:27:13 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5SARC0j006148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 06:27:12 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5SAQeIr312282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 04:26:40 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5SARBgd018046
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 04:27:12 -0600
In-Reply-To: <20060612140538.GA3892@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian King <brking@us.ibm.com>, Doug Maxey <dwm@bebe.enoyolf.org>, Unicorn Chang <uchang@tw.ibm.com>

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
> resume all ports of a controller.  


> host_set/port representation will
> be improved to handle legacy controllers better and this host_set
> linking will go away with it.
> 

Hi Tejun,

Hmm, the current patch looks more like a temporary solution. The legacy mode
ATA_HOST_SIMPLEX host_set->flags could be assigned to both legacy ports.
In the long term, have one host_set for both legacy ports
instead of two host_sets for both legacy ports can fix the problem.

A patch was submitted by Unicorn, but it looks not good/elegant enough. :(
It will be nice if you have plan for furthur legacy two host_sets case fixes...

Thanks,

Albert


