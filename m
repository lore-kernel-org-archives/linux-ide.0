From: Tejun Heo <htejun@gmail.com>
Subject: shutdown.html update
Date: Thu, 07 Jun 2007 18:27:57 +0900
Message-ID: <4667CF9D.1090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:55860 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXFGJ2E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 05:28:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so525170wah
        for <linux-ide@vger.kernel.org>; Thu, 07 Jun 2007 02:28:04 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

Updated version of shutdown.html is at

  http://htj.dyndns.org/shutdown.html

/sys/block/sdX/device/scsi_disk:h:c:i:l/ link may not exist depending on
configuration (CONFIG_SYSFS_DEPRECATED I think).  Update shutdown.html
accordingly.

Thanks.

-- 
tejun
