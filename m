From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-2.6 1/5] Fix zero sg_dma_len() on 64-bit platform
Date: Wed, 23 Mar 2005 00:19:05 -0500
Message-ID: <4240FC49.1030206@pobox.com>
References: <423A834D.5080407@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24452 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262790AbVCWFTT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Mar 2005 00:19:19 -0500
In-Reply-To: <423A834D.5080407@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Just FYI...  I'll review and merge these patches tomorrow.

 From a quick glance, they look sane, modulo the ATAPI padding comments 
earlier.

	Jeff



