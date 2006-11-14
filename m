From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: trivial updates to ata_sg_init_one()
Date: Tue, 14 Nov 2006 14:26:34 -0500
Message-ID: <455A186A.4090207@pobox.com>
References: <20061114133543.GB27684@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35273 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966283AbWKNT0g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 14:26:36 -0500
In-Reply-To: <20061114133543.GB27684@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> There's no need to memset &qc->sgent manually, sg_init_one() clears
> sgent inside it.  Also, kill not-so-necessary sg local variable.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


