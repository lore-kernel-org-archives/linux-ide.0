From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-core when not ata_id_use_dmadir despite yes SiliconI
 mage
Date: Sat, 15 May 2004 12:39:57 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A647DD.4020601@pobox.com>
References: <1084630807.5082.42.camel@patibmrh9> <200405151633.10473.bzolnier@elka.pw.edu.pl> <40A64229.7000600@pobox.com> <200405151838.15898.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6814 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264695AbUEOQkM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 12:40:12 -0400
In-Reply-To: <200405151838.15898.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Pat LaVarre <p.lavarre@ieee.org>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 15 of May 2004 18:15, Jeff Garzik wrote:
>>We can do so for our development here, but a better solution based on
>>released parts will need to be found...
> 
> 
> Do you know of some way to detect SI 3611CT80 1.4?


Not right now.

I need to see the full IDENTIFY PACKET DEVICE data to discover a way... 
  (and I need to write some code before libata dumps the full 
identify-device page)

Other bridges add an identifying string to the -end- of the ATA device's 
model name, maybe SiI does too.

	Jeff



