From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI work in progress
Date: Thu, 13 May 2004 17:49:10 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A3ED56.3010509@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>	<1084403654.3196.31.camel@patibmrh9> <40A3E595.8000003@pobox.com><40A3E7E5.	6060403@pobox.com> <1084484186.4524.3.camel@patibmrh9> <40A3EC46.4050909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65217 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265122AbUEMVtX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 17:49:23 -0400
In-Reply-To: <40A3EC46.4050909@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 5) do the same for ata_bmdma_{start,setup}_pio.

Whoops, I left out a rather important step:

5.5) Everywhere that libata-core and libata-scsi call the 
->bmdma_start() hook, add a call to the new ->bmdma_setup hook 
immediately before it.


