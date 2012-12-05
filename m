From: Aaron Lu <aaron.lu@intel.com>
Subject: Long delays when waking up from suspend-to-ram on Gigabyte MB with
 JMicron controller
Date: Wed, 05 Dec 2012 09:23:54 +0800
Message-ID: <50BEA22A.1020300@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30635 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab2LEBXu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2012 20:23:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Show Lu <showlu@jmicron.com>
Cc: Mehmet Giritli <mehmet@giritli.eu>, Steven Chen <stevenchen@jmicron.com>, Orson <orson.wellies@gmail.com>, Aries Lee <arieslee@jmicron.com>, Jonathan Nieder <jrnieder@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hi Show,

Can you please take a look at the following bugzilla? Mehmet has
problems resuming his system, the port keeps reporting connection status
change event:
https://bugzilla.kernel.org/show_bug.cgi?id=47831

This is kind of like the issue I found here:
http://marc.info/?l=linux-ide&m=132609120812842&w=2

Suggestions are welcome.

The fact that Windows does not have a problem with the card made me
think:
1 Either Linux's driver has a problem;
2 Or Windows' driver has a quirk but we don't know.

Thanks,
Aaron

