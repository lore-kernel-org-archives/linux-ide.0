From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: hdparm -S  with SATA drives.
Date: Wed, 16 Mar 2005 23:14:24 +0000
Message-ID: <4238BDD0.6020400@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:11282 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S262881AbVCPXOz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Mar 2005 18:14:55 -0500
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.42)
	id 1DBhil-0004HA-7y
	for linux-ide@vger.kernel.org; Wed, 16 Mar 2005 23:14:35 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Can one use the following command with libata yet?

hdparm -S 240 /dev/sda

James
