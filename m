From: Thorsten Leemhuis <fedora@leemhuis.info>
Subject: Re: [patch 2.6.22-rc6] ATA: add a PCI ID for Intel Santa Rosa PATA
 controller
Date: Mon, 02 Jul 2007 11:07:32 +0200
Message-ID: <4688C054.2030208@leemhuis.info>
References: <468408F1.3080307@redhat.com> <46841062.2080800@redhat.com> <468886E1.7080302@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tzmxr01.htp-tel.de ([81.14.243.17]:47270 "EHLO
	TZMXR01.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXGBJHt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 05:07:49 -0400
In-Reply-To: <468886E1.7080302@leemhuis.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Lamparter <chunkeey@web.de>
Cc: Chuck Ebbert <cebbert@redhat.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jason Gaston <jason.d.gaston@intel.com>

On 02.07.2007 07:02, Thorsten Leemhuis wrote:
> On 28.06.2007 21:47, Chuck Ebbert wrote:
>> On 06/28/2007 03:16 PM, Chuck Ebbert wrote:
>>
>> [Forgot to mark subj: as a patch; attached]
>>
>>> From: Christian Lamparter <chunkeey@web.de>
>>>
>>> ATA: add a PCI ID for Intel Santa Rosa PATA controller.
>>>
>>> Signed-off-by: Christian Lamparter <chunkeey@web.de>
>>> ---
>> [...]
>>> +       /* ICH8 Mobile PATA Controller */
>>> +       { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
> 
> FYI: Patch works fine for me on my brand new Dell D630 (Santa Rosa) --
> the DVD-Drive gets recognized with it applied.

Hmmm. From looking at the ICH8-Datasheet (
http://www.intel.com/design/chipsets/datashts/313056.htm
or http://download.intel.com/design/chipsets/datashts/31305603.pdf )
page 189 and later it seems to me that the ICH8M (just as all the other
Intel-Chipsets I know) officially only supports Ultra ATA 100 (and not
133!).

So is the ich_pata_133 correct in the patch (see quoted line above)?

CU
thl
