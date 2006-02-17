From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: make ata_sg_setup_one() trim zero length sg
Date: Fri, 17 Feb 2006 16:34:37 -0500
Message-ID: <43F6416D.50807@pobox.com>
References: <20060217075309.GA31835@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:42988 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751437AbWBQVem (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 16:34:42 -0500
In-Reply-To: <20060217075309.GA31835@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch makes ata_sg_setup_one() trim sg entry (thus making
> qc->n_elem zero) if padding results in zero length sg entry.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> Jeff, currently, in both sg_setup() and sg_setup_one() cases, zero
> length sg entry can reach low level driver fill_sg() function which
> could possibly cause weird problems.  This and a following patch kill
> such cases.

Can you redo this series against vanilla upstream (and/or #upstream-fixes)?

	Jeff



