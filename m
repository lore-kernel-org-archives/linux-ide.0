From: Stefan <gentoopower@yahoo.de>
Subject: Sis 748 and 964 should be added to driver messages
Date: Mon, 10 May 2004 14:45:35 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <409F796F.2040209@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:28003 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264667AbUEJMiv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2004 08:38:51 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Sorry again for spamming the list with my false 2.6.6 kernel bugalaram!

This time I just wanted to mention, that the kernel still doesn't 
mention or recognize my chipset correctly.
I have the messages:

kernel: agpgart: Detected SiS 746 chipset
kernel: SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller

But my board features SIS 748 and SIS 964. Since this is ide mailinglist 
can the maintainer of the sis ide driver add this to the kern_info and 
kernel config help.
The ide driver works fine and I guess there is no difference in the ide 
module for 964 compared to 962/963.

Thanks
