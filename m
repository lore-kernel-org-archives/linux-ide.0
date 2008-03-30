From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Sun, 30 Mar 2008 09:03:55 +0200
Message-ID: <47EF3B5B.4060005@dunaweb.hu>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org> <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu> <47EEDACA.4060400@gmail.com> <47EEE784.8090909@shaw.ca> <47EEEA2B.8010204@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060905040406080303020807"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dunaweb.hu ([81.17.184.3]:47514 "EHLO mail.dunaweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbYC3HEB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Mar 2008 03:04:01 -0400
In-Reply-To: <47EEEA2B.8010204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

This is a multi-part message in MIME format.
--------------060905040406080303020807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Tejun Heo =EDrta:
> Robert Hancock wrote:
>> Tejun Heo wrote:
>>> Zoltan Boszormenyi wrote:
>>>> Tejun Heo =EDrta:
>>>>> akpm@linux-foundation.org wrote:
>>>>>> From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>>>>>
>>>>>> unchangelogged patch.
>>>>>>
>>>>>> Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>>>>> Cc: Robert Hancock <hancockr@shaw.ca>
>>>>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>>>
>>>>> Nacked-by: Tejun Heo <htejun@gmail.com>
>>>>>
>>>>> Sorry, there are remaining issues to resolve before enabling ADMA=20
>>>>> by default.
>>>>
>>>> Sorry, this is NOT ADMA. SWNCQ is completely independent from ADMA.
>>>
>>> Heh, right.  Sorry about that.  I disabled ADMA on the distro I work =

>>> for and somehow ADMA was disabled on mainline too.  :-)
>>>
>>> Robert, is SWNCQ safe to turn on by default?  I personally think=20
>>> it's better to prefer safety over performance or optional features=20
>>> and given the history of NCQ support on nv satas, I feel a bit more=20
>>> cautious.
>>>
>>> Maybe we can enable SWNCQ on -mm and devel branches and disable it=20
>>> late in release cycle for 2.6.26 for a trial?
>>
>> I haven't seen any problem reports, but with it disabled by default=20
>> most people haven't tried it. The only way to really know is to try=20
>> turning it on by default and see what shakes out.
>>
>> I'd vote to enable it by default in -mm and 2.6.26-rc and see what=20
>> happens.
>
> Alright, Zoltan can you please repost w/ commit message fixed and=20
> comment stating /* FIXME: for testing during blah blah */ added?
>

You mean like this?


--------------060905040406080303020807
Content-Type: text/x-patch;
 name="sata_nv-swncq_enabled-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_nv-swncq_enabled-1.patch"

Enable SWNCQ by default for testing in 2.6.26-rcX[-mm] and 

Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: Robert Hancock <hancockr@shaw.ca>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/sata_nv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ata/sata_nv.c~ata-swncq-should-be-enabled-by-default drivers/ata/sata_nv.c
--- a/drivers/ata/sata_nv.c~ata-swncq-should-be-enabled-by-default
+++ a/drivers/ata/sata_nv.c
@@ -532,7 +532,7 @@ MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
 static int adma_enabled = 1;
-static int swncq_enabled;
+static int swncq_enabled = 1;	/* FIXME: for testing during 2.6.26-rcX[-mmY] */
 
 static void nv_adma_register_mode(struct ata_port *ap)
 {
@@ -2485,5 +2485,5 @@ module_exit(nv_exit);
 module_param_named(adma, adma_enabled, bool, 0444);
 MODULE_PARM_DESC(adma, "Enable use of ADMA (Default: true)");
 module_param_named(swncq, swncq_enabled, bool, 0444);
-MODULE_PARM_DESC(swncq, "Enable use of SWNCQ (Default: false)");
+MODULE_PARM_DESC(swncq, "Enable use of SWNCQ (Default: true)");
 

--------------060905040406080303020807--
