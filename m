From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2] ahci: platform support for suspend/resume
Date: Thu, 15 Dec 2011 11:53:27 -0800
Message-ID: <CAN8TOE-GZEFKKVKiR_oAumj3BhcCrO66mCUyiPBPVUUPFX2YBQ@mail.gmail.com>
References: <1321643410-16102-1-git-send-email-computersforpeace@gmail.com>
	<20111118192809.GF11736@legolas.emea.dhcp.ti.com>
	<CAN8TOE-yZyHC3n+dSu9wZ=UBmenD67OHbAyrF2K_sgf0O7oUJA@mail.gmail.com>
	<4EEA47FD.4050407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41016 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759350Ab1LOTx3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Dec 2011 14:53:29 -0500
In-Reply-To: <4EEA47FD.4050407@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: balbi@ti.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Kevin Cernekee <cernekee@gmail.com>, Lin Ming <ming.m.lin@intel.com>

On Thu, Dec 15, 2011 at 11:18 AM, Jeff Garzik <jgarzik@pobox.com> wrote=
:
> On 12/15/2011 01:13 PM, Brian Norris wrote:
>>
>> On Fri, Nov 18, 2011 at 11:28 AM, Felipe Balbi<balbi@ti.com> =A0wrot=
e:
>>>
>>> On Fri, Nov 18, 2011 at 11:10:10AM -0800, Brian Norris wrote:
>>>>
>>>> Add platform hooks for custom suspend() and resume() functions. Th=
e
>>>> generic suspend/resume code in drivers/ata/ahci_platform.c is adap=
ted
>>>> from the PCI version in drivers/ata/ahci.c.
>>>>
>>>> Signed-off-by: Brian Norris<computersforpeace@gmail.com>
>>>
>>>
>>> Reviewed-by: Felipe Balbi<balbi@ti.com>
>>
>>
>> Thanks for the review, Felipe.
>>
>> What's the status on this? There have been no comments for almost a
>> month. Can it be merged?
>
>
> The previous version was queued, but did not apply to upstream (I ema=
iled a
> comment at the time). =A0Hopefully this one works...

I never saw a comment that it did not apply. Anyway, by my own tests,
this version applies safely to either Linus' repository or your
libata-dev/NEXT branch.

Brian
