From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 4.2] ata: ahci_brcmstb: Fix warnings with CONFIG_PM_SLEEP=n
Date: Mon, 27 Jul 2015 12:54:07 -0700
Message-ID: <55B68C5F.5050301@gmail.com>
References: <1436904213-9205-1-git-send-email-f.fainelli@gmail.com> <20150714220629.GA21362@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34423 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbbG0T4L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jul 2015 15:56:11 -0400
In-Reply-To: <20150714220629.GA21362@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, gregory.0xf0@gmail.com

On 14/07/15 15:06, Brian Norris wrote:
> On Tue, Jul 14, 2015 at 01:03:33PM -0700, Florian Fainelli wrote:
>> When CONFIG_PM_SLEEP is disabled, brcm_ahci_{suspend,resume} are not
>> used, which causes such a build warning to occur:
>>
>>   CC      drivers/ata/ahci_brcmstb.o
>> drivers/ata/ahci_brcmstb.c:212:12: warning: 'brcm_ahci_suspend' defined
>> but not used [-Wunused-function]
>>  static int brcm_ahci_suspend(struct device *dev)
>>             ^
>> drivers/ata/ahci_brcmstb.c:224:12: warning: 'brcm_ahci_resume' defined
>> but not used [-Wunused-function]
>>  static int brcm_ahci_resume(struct device *dev)
>>             ^
>>   LD      drivers/ata/built-in.o
>>
>> Fixes: 766a2d979632 ("ata: add Broadcom AHCI SATA3 driver for STB chips")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> Tejun, this is a new driver that got merged during 4.2, could you queue
>> this up for an upcoming 4.2-rcX pull request?
> 
> Acked-by: Brian Norris <computersforpeace@gmail.com>
> 

Tejun, I am not seeing this change queued in your for-4.2-fixes branch
did you need me to do anything?
-- 
Florian
