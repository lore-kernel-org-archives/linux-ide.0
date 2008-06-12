From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc: remove mpc8xx-ide driver
Date: Thu, 12 Jun 2008 07:48:58 -0500
Message-ID: <325FF1AB-AFFA-45EE-9796-25D5004F27BB@kernel.crashing.org>
References: <20080610142702.354823071@arndb.de> <20080610142947.711491620@arndb.de> <200806102101.20156.bzolnier@gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36227 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757050AbYFLMt3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jun 2008 08:49:29 -0400
In-Reply-To: <200806102101.20156.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-ide@vger.kernel.org


On Jun 10, 2008, at 2:01 PM, Bartlomiej Zolnierkiewicz wrote:

>
> Hi,
>
> On Tuesday 10 June 2008, arnd@arndb.de wrote:
>> This driver was only used by arch/ppc code and is obsolete
>> now with the move to common arch/powerpc code.
>>
>> Cc: linux-ide@vger.kernel.org
>> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> drivers/ide/Kconfig      |   10 -
>> drivers/ide/ppc/Makefile |    1 -
>> drivers/ide/ppc/mpc8xx.c |  847  
>> ----------------------------------------------
>> 3 files changed, 0 insertions(+), 858 deletions(-)
>> delete mode 100644 drivers/ide/ppc/mpc8xx.c
>
> Thanks, applied.
>
> [ there is a couple of patches in IDE tree touching this driver so I  
> needed
>  to refresh the patch - IOW it now removes the "freshest" mpc8xx.c  
> version ]
>
> Paul/Kumar: I hope you are fine with this.

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k

