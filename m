From: Kallol Biswas <kallol@nucleodyne.com>
Subject: Enabling MSI on SATAII150
Date: 26 Jun 2005 18:11:50 -0700
Message-ID: <1119834710.13331.654.camel@driver>
References: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>
	 <42AC6310.7030809@rtr.ca> <1118598197.25250.20.camel@driver>
	 <42ACFFED.9050701@pobox.com>
Reply-To: kallol@nucleodyne.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:1687 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261697AbVF0BNC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 21:13:02 -0400
In-Reply-To: <42ACFFED.9050701@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Hello Jeff,
          We have been using the sx8 driver on a MIPS based custom
platform.
It seems the line based interrupt mechanism is broken on the system.

SATA1150 controller supports MSI interrupt like other PCI-X devices.

Unfortunately we do not have access to the controller's technical
specification yet.

Would it be possible to send us a reply detailing how to enable
MSI interrupt on the adapter?

BTW, with CARM_MAX_Q == 30 and a workaround to fix lost interrupt we
have got good performance with the driver. Thanks for good work. MSI
will help improve performance more, as there won't be any delay
associated with handling lost interrupt.


Kallol
     

