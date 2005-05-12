From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Experimental git repositories available for SATA
Date: Thu, 12 May 2005 19:01:08 -0400
Message-ID: <4283E034.90904@pobox.com>
References: <4283C2F8.6020801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:209 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262168AbVELXBM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 May 2005 19:01:12 -0400
In-Reply-To: <4283C2F8.6020801@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Jeff Garzik wrote:
>> [jgarzik@pretzel libata-dev]$ ls .git/refs/heads/
>> adma        atapi-enable        iomap        pdc2027x
>> adma-mwi    bridge-detect       iomap-step1  pdc20619
>> ahci-atapi  chs-support         master       promise-sata-pata
>> ahci-msi    ioctl-get-identity  passthru     sil24

For libata-dev.git, I moved these into the main (.git) directory, so 
that things work a bit easier with Linus's scripts.

	Jeff


