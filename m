From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19-rc6] sata_promise updates
Date: Tue, 21 Nov 2006 16:17:18 -0500
Message-ID: <45636CDE.8020603@garzik.org>
References: <200611212057.kALKvL8n009798@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:62174 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031431AbWKUVR1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Nov 2006 16:17:27 -0500
In-Reply-To: <200611212057.kALKvL8n009798@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

And......  is there any chance you could be talked into working on these 
sata_promise to-dos:

* conversion to new error handling system (grep for 'freeze', 'thaw', 
'error_handler', replaces 'phy_reset' and 'eng_timeout')

* support for ATAPI devices (just need to set up ATAPI commands via the 
packet format described in the public docs)

* support for command queueing

Command queueing is the most involved task, the others should be 
reasonably straightforward.

Cheers!

	Jeff




