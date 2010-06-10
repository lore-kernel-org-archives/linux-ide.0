From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v3] libata: pata_samsung_cf: Add Samsung PATA controller
 driver
Date: Thu, 10 Jun 2010 05:37:53 -0400
Message-ID: <4C10B271.6040908@pobox.com>
References: <1276156241-28804-1-git-send-email-kgene.kim@samsung.com> <4C10A7B7.4090601@pobox.com> <20100610085639.GU7248@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34272 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab0FJJh4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2010 05:37:56 -0400
In-Reply-To: <20100610085639.GU7248@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, linux-ide@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06/10/2010 04:56 AM, Ben Dooks wrote:
> On Thu, Jun 10, 2010 at 04:52:07AM -0400, Jeff Garzik wrote:
>> On 06/10/2010 03:50 AM, Kukjin Kim wrote:
>>> From: Abhilash Kesavan<a.kesavan@samsung.com>
>>>
>>> Adds support for the Samsung PATA controller. This driver is based on the
>>> Libata subsystem and references the earlier patches sent for IDE subsystem.
>>>
>>> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
>>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>>> ---
>>>
>>> Changes since v2:
>>> - Changed the DRV_NAME to pata_samsung_cf
>>> - Used msleep instead of mdelay
>>>
>>>    drivers/ata/Makefile          |    1 +
>>>    drivers/ata/pata_samsung_cf.c |  608 +++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 618 insertions(+), 0 deletions(-)
>>>    create mode 100644 drivers/ata/pata_samsung_cf.c
>>
>> Acked-by: Jeff Garzik<jgarzik@redhat.com>
>>
>>
>> I presume you'll send this upstream via the appropriate ARM tree.
>
> It depends on whether Linus un-declares his current suspensio nof
> ARM based work. The machine updtaes should go via the samsung tree
> but whether to send the driver that was is another matter (I prefer
> to have drivers go via the driver's tree to avoid clashes in
> Makefile and Kconfig).

I don't mind merging it, but usually platform drivers do not build 
and/or work without additional platform glue.  Isn't that the case here?


> PS, what's your policy on -rc inclusion of completely new code
> such as this?

New drivers are fine (which is standard policy outside libata, too), as 
they will not cause regressions, and will enable new users.

	Jeff



