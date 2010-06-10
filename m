From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH v3] libata: pata_samsung_cf: Add Samsung PATA
	controller driver
Date: Thu, 10 Jun 2010 09:56:39 +0100
Message-ID: <20100610085639.GU7248@trinity.fluff.org>
References: <1276156241-28804-1-git-send-email-kgene.kim@samsung.com> <4C10A7B7.4090601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C10A7B7.4090601@pobox.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, linux-ide@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jun 10, 2010 at 04:52:07AM -0400, Jeff Garzik wrote:
> On 06/10/2010 03:50 AM, Kukjin Kim wrote:
>> From: Abhilash Kesavan<a.kesavan@samsung.com>
>>
>> Adds support for the Samsung PATA controller. This driver is based on the
>> Libata subsystem and references the earlier patches sent for IDE subsystem.
>>
>> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>> ---
>>
>> Changes since v2:
>> - Changed the DRV_NAME to pata_samsung_cf
>> - Used msleep instead of mdelay
>>
>>   drivers/ata/Makefile          |    1 +
>>   drivers/ata/pata_samsung_cf.c |  608 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 618 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/ata/pata_samsung_cf.c
>
> Acked-by: Jeff Garzik <jgarzik@redhat.com>
>
>
> I presume you'll send this upstream via the appropriate ARM tree.

It depends on whether Linus un-declares his current suspensio nof
ARM based work. The machine updtaes should go via the samsung tree
but whether to send the driver that was is another matter (I prefer
to have drivers go via the driver's tree to avoid clashes in
Makefile and Kconfig).

PS, what's your policy on -rc inclusion of completely new code
such as this?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
