From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Tue, 30 Nov 2010 22:10:51 +0200
Message-ID: <4CF55A4B.1020402@iki.fi>
References: <4C4AFE7C.5070506@kernel.org> <4CF45BC0.2030701@iki.fi> <4CF4FCBE.2060406@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from saarni.dnainternet.net ([83.102.40.136]:58810 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0K3UK6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Nov 2010 15:10:58 -0500
In-Reply-To: <4CF4FCBE.2060406@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>

On 30.11.2010 15:31, Tejun Heo wrote:
> Hello,
> 
> On 11/30/2010 03:04 AM, Anssi Hannula wrote:
>> On 24.07.2010 17:53, Tejun Heo wrote:
>>> 88SE9128 can do FBS and sets it in HOST_CAP but forgets to set FBSCP
>>> in PORT_CMD.  Implement AHCI_HFLAG_YES_FBS and apply it to 88SE9128.
>>>
>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> [...]
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index f252253..41fa0a3 100644
>> [...]
>>> @@ -362,6 +371,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>>  	/* Marvell */
>>>  	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
>>>  	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
>>> +	{ PCI_DEVICE(0x1b4b, 0x9123),
>>> +	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
>>
>> The device contains an IDE interface as well, and the above
>> pci_device_id matches them both:
>> 08:00.0 SATA controller [0106]: Device [1b4b:9123] (rev 10)
>> 08:00.1 IDE interface [0101]: Device [1b4b:9123] (rev 10)
> 
> *GASP* Come on Marvell.... :-(
> 
>> This results in some (apparently harmless) mess [1].
>>
>> Attached is a patch to make the id entry class-specific. The patch is
>> untested (the issue happens in a production machine).
> 
> Thanks a lot for the patch.  It looks correct but it would be great if
> it can be veified.

I think I can do that later, but probably not this week or so.

> Also, there's a pending patch to add another PCI
> ID for similar marvell controller.  I wonder whether similar
> workaround should be applied.  Hmmm... ISTR the other one reporting
> IDE class even though it works in IDE mode.

IDE class in IDE mode? Isn't that kind of expected? :)

Also, just to avoid any misunderstanding: I see both the SATA and IDE
interfaces at the same time.

> Can someone with marvell
> documentation access check what's going on?
> 
> Thanks.
> 

-- 
Anssi Hannula
