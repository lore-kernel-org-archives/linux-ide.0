From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] ata: disable port while unloading ATA controller driver
Date: Wed, 30 Nov 2016 00:15:50 +0200
Message-ID: <b33224b4-0f20-9c8d-38e3-2e6b2e8882a9@mleia.com>
References: <20161127231856.11466-1-vz@mleia.com>
 <20161128183425.GA19096@htj.duckdns.org>
 <a498fb9f-822e-45aa-aac1-c7afae7a44e3@mleia.com>
 <09c7866c-ecd4-f48a-5112-6cf3c6786cd9@mleia.com>
 <20161129190025.GC22330@htj.duckdns.org>
 <cf257dae-7811-0338-3b59-050f34c1ae29@mleia.com>
 <20161129204413.GC4959@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:57876 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755167AbcK2WPx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 29 Nov 2016 17:15:53 -0500
In-Reply-To: <20161129204413.GC4959@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

Hello Tejun,

I'm adding Rob (author of TEST_DRIVER_REMOVE) to Cc in case if he
has interest in the topic.

On 11/29/2016 10:44 PM, Tejun Heo wrote:
> Hello, Vladimir.
> 
> On Tue, Nov 29, 2016 at 10:04:14PM +0200, Vladimir Zapolskiy wrote:
>>> Not really.  Is this from the unloading test config?
>>
>> Correct, I always get the warning with CONFIG_DEBUG_TEST_DRIVER_REMOVE
>> option enabled.
>>
>> I understand that a working solution might be just to disable the
>> option rather than handle this case, however because it is wanted
>> to test other drivers for potential errors also (e.g. the same ATA
>> controller driver regardless of the false positive in the ATA core), 
>> in my opinion the issue should not be ignored.
> 
> So, the problem is that CONFIG_DEBUG_TEST_DRIVER_REMOVE is introducing
> a condition which isn't otherwise possible, so it's triggering pseudo
> bugs.  The solution here is to make CONFIG_DEBUG_TEST_DRIVER_REMOVE
> flush async calls before trying to remove the driver.
> 

in case if I haven't tired you out yet, I verified you solution and it
works perfectly, there is no problem in ATA subsystem which I can point
out:

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d76cd97..a4feecf 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -384,6 +384,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (test_remove) {
 		test_remove = false;
 
+		async_synchronize_full();
+
 		if (dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)

In my understanding the code under "if (test_remove)" branch should be
close to the code of __device_release_driver() function, but here it
is slightly different on purpose --- driver_allows_async_probing(drv)
returns false in case of the ATA controller driver(s), here async
probing is not a functional part of a driver, but it is embedded into
the ATA subsystem by means of generic async_port_probe(). Not sure if
__device_release_driver() or driver_allows_async_probing() should be
corrected respecting this case, and hence I'm not going to touch it.

>>> Control doesn't get passed to userland until async probings are
>>> flushed, so this shouldn't normally be possible.
>>>
>>
>> I'm not an expert in ATA, can you please show me the synchronization
>> point?
> 
> async_synchronize_full() call in kernel_init() for booting and in
> delete_module() for module unloading.
> 

Thank you for discussion and support.

--
With best wishes,
Vladimir
