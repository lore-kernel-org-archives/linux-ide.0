From: Thorsten Leemhuis <fedora@leemhuis.info>
Subject: Re: [patch 2.6.22-rc6] ATA: add a PCI ID for Intel Santa Rosa PATA
 controller
Date: Mon, 02 Jul 2007 07:02:25 +0200
Message-ID: <468886E1.7080302@leemhuis.info>
References: <468408F1.3080307@redhat.com> <46841062.2080800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tzmxr02.htp-tel.de ([81.14.243.18]:26252 "EHLO
	TZMXR02.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbXGBFT1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 01:19:27 -0400
In-Reply-To: <46841062.2080800@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jason Gaston <jason.d.gaston@intel.com>

On 28.06.2007 21:47, Chuck Ebbert wrote:
> On 06/28/2007 03:16 PM, Chuck Ebbert wrote:
> 
> [Forgot to mark subj: as a patch; attached]
> 
>> From: Christian Lamparter <chunkeey@web.de>
>>
>> ATA: add a PCI ID for Intel Santa Rosa PATA controller.
>>
>> Signed-off-by: Christian Lamparter <chunkeey@web.de>
>> ---
> [...]
>> +       /* ICH8 Mobile PATA Controller */
>> +       { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },

FYI: Patch works fine for me on my brand new Dell D630 (Santa Rosa) --
the DVD-Drive gets recognized with it applied.

CU
thl
