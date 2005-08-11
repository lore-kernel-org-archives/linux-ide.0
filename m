From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 03/07] sil24: add testing for PCI
 fault
Date: Thu, 11 Aug 2005 15:19:08 -0400
Message-ID: <42FBA4AC.6090906@pobox.com>
References: <20050730101344.1C985988@htj.dyndns.org> <20050730101344.F6A4E6BD@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:52391 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932387AbVHKTTM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 15:19:12 -0400
In-Reply-To: <20050730101344.F6A4E6BD@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 03_sil24_add-test-for-PCI-fault.patch
> 
> 	On entry to interrupt handler, PORT_SLOT_STAT register is read
> 	first.  Check if PCI fault or device removal has occurred by
> 	testing the value for 0xffffffff.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


