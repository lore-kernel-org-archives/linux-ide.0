From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata-dev#upstream pdc_adma fails IDENTIFY w/ AC_ERR_HSM
Date: Fri, 04 Aug 2006 11:30:43 -0400
Message-ID: <44D36823.7020406@pobox.com>
References: <44D336EE.5000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:19661 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932589AbWHDPaw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Aug 2006 11:30:52 -0400
In-Reply-To: <44D336EE.5000907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> [adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
> [ata_port_flush_task ] ENTER
> [ata_port_flush_task ] flush #1
> ata1: ata_port_flush_task: flush #2
> ata1: ata_port_flush_task: EXIT
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)


AC_ERR_HSM comes from the call to ac_err_mask().  Given a Status of 
0x58, it would appear that DRQ is asserted.

So if I had to guess, I would say that the above interrupt is the 
DRQ-is-asserted indication, which would imply perhaps that this driver 
should not bother with PIO polling.

	Jeff



