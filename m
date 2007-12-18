From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/10] libata-acpi: adjust constness in ata_acpi_gtm/stm()
 parameters
Date: Mon, 17 Dec 2007 20:35:38 -0500
Message-ID: <476723EA.10601@garzik.org>
References: <11976987063011-git-send-email-htejun@gmail.com> <11976987061239-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37098 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbXLRBfl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 20:35:41 -0500
In-Reply-To: <11976987061239-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: hancockr@shaw.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> * No internal function uses const ata_port.  Drop const from @ap.
> 
> * Make ata_acpi_stm() copy @stm before using it and change @stm to
>   const.

for the record, I -would- use const ata_port where feasible; its just so 
rarely feasible, since members of that struct are often being modified. 
  However in a small query-style function, I could see some const-ness 
perhaps...

	Jeff



