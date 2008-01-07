From: Tejun Heo <htejun@gmail.com>
Subject: disabling sata_nv ADMA for 2.6.24
Date: Mon, 07 Jan 2008 18:25:28 +0900
Message-ID: <4781F008.9070404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:51430 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610AbYAGJZd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 04:25:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so12403312wah.23
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 01:25:33 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

Hello, guys.

We still have three problems with ADMA.

* hard lockup during resume
* occasional hard lockup after hotplug or other erros (probably related
to the above?)
* occasional timeout of FLUSH after NCQ writes

I think we should disable ADMA for 2.6.24 and -stable for now.  What do
you guys think?

Thanks.

-- 
tejun
