From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] Enable parallel scan on ata_piix
Date: Fri, 24 Apr 2009 07:33:46 -0400
Message-ID: <49F1A39A.3080606@garzik.org>
References: <20090423214411.515310df@infradead.org>	<49F19491.2030901@garzik.org> <20090424122822.64b143c7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39584 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbZDXLd4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Apr 2009 07:33:56 -0400
In-Reply-To: <20090424122822.64b143c7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
>> I tend to doubt "safe", given the complicated and buggy silicon state 
>> machine that recreates the legacy IDE interface on SATA...
> 
> The two channels on the ICH and PIIX are independant. There are other

Starting with ICH5, not true.  Think PATA/SATA combined mode...

	Jeff



