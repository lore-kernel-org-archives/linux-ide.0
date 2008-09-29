From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH] pata_of_platform: fix no irq handling
Date: Mon, 29 Sep 2008 17:32:36 +0400
Message-ID: <20080929133236.GA19675@oksana.dev.rtsoft.ru>
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn> <2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com> <20080925104847.GA311@oksana.dev.rtsoft.ru> <48E05742.1030609@pobox.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:55693 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750819AbYI2Nci (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 09:32:38 -0400
Content-Disposition: inline
In-Reply-To: <48E05742.1030609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Li Yang <leoli@freescale.com>, Wang Jian <lark@linux.net.cn>, "Steven A. Falco" <sfalco@harris.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

When no irq specified the pata_of_platform fills the irq_res with -1,
which is wrong to do for two reasons:

1. By definition, 'no irq' should be IRQ 0, not some negative integer;
2. pata_platform checks for irq_res.start > 0, but since irq_res.start
   is unsigned type, the check will be true for `-1'.

Reported-by: Steven A. Falco <sfalco@harris.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Mon, Sep 29, 2008 at 12:19:14AM -0400, Jeff Garzik wrote:
> Anton Vorontsov wrote:
>> On Thu, Sep 25, 2008 at 06:40:59PM +0800, Li Yang wrote:
>>> On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
>>>> The alternative fix can be.
>>> This one is better as 0 is defined as 'invalid irq' for all
>>> architectures.  Added linux-ide and Anton to cc.
>>
>> Thanks for the correct Cc.
>>
>> I've sent a patch to fix the issue more than a month ago.
>>
>> http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg22851.html
>>
>> Jeff, could you apply the patch?
>
> Can you resend, I don't seem to have it...

Here it is.

Thanks,

 drivers/ata/pata_of_platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 408da30..1f18ad9 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
 
 	ret = of_irq_to_resource(dn, 0, &irq_res);
 	if (ret == NO_IRQ)
-		irq_res.start = irq_res.end = -1;
+		irq_res.start = irq_res.end = 0;
 	else
 		irq_res.flags = 0;
 
-- 
1.5.6.3

