From: Unicorn Chang <uchang@tw.ibm.com>
Subject: [PATCH 0/2] libata: legacy mode fixes , take #2
Date: Tue, 20 Jun 2006 12:41:39 +0800
Message-ID: <44977C83.3000404@tw.ibm.com>
References: <OFCF0117DA.A67C46D9-ON48257193.00125DE7-48257193.00127E8D@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:55442 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964924AbWFTEle
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 00:41:34 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5K4fVvB005080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 00:41:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5K4fedC106830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 22:41:40 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5K4fUrl004469
	for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 22:41:30 -0600
In-Reply-To: <OFCF0117DA.A67C46D9-ON48257193.00125DE7-48257193.00127E8D@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


For a legacy ATA controller, libata registers two separate host sets problems.
There are two patch use the same way to fix this problems, but the SIMPLEX flag
is still assigned to both host_sets of legacy primary/secondary port.

http://marc.theaimsgroup.com/?l=linux-ide&m=115012115213127&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=114475219522457&w=2

This patch try to fix the problems by

1. Let both legacy ports share the same host_set for the ATA_HOST_SIMPLEX
   to work.
2. Add per port irq to ata_ioports for legacy irq 14/15 since
   host_set is shared now.
3. Add legacy irq handler (ata_nonshared_interrupt) to support legacy mode irq.
4. Pass struct ata_port* to request_irq() on legacy mode.


(Patch against the upstream branch)

Unicorn Chang



