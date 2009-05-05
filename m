From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [stable] [PATCH] cs5536: define dma_sff_read_status() method
Date: Tue, 05 May 2009 14:35:59 +0400
Message-ID: <4A00168F.1060308@ru.mvista.com>
References: <200904072003.40866.sshtylyov@ru.mvista.com> <20090504215906.GC31248@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4752 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754576AbZEEKed (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 May 2009 06:34:33 -0400
In-Reply-To: <20090504215906.GC31248@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, stable@kernel.org

Greg KH wrote:

>>The driver somehow got merged with the initializer for the dma_sff_read_status()
>>method missing which caused kernel panic on bootup.

>>This should fix the kernel.org bug #13026...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>>This patch is against the recent Linus' tree.
>>It should go into 2.6.29-stable as the driver was merged/broken in 2.6.29 time.

> It doesn't apply to the 2.6.29-stable tree at all.

> Care to redo your patch to apply there?

    Hm, I thought it was obvious enough... will redo.

> thanks,

> greg k-h

MBR, Sergei
