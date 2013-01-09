From: Josh Coombs <josh.coombs@gmail.com>
Subject: Re: [PATCH] Allow Marvell SATA driver to work with LEDS_TRIGGER_IDE_DISK
Date: Wed, 9 Jan 2013 11:19:25 -0500
Message-ID: <CAMW5Ufb4LMPR86A7AMMeGzkcYzgGWVruGAQT6E7irAacZegzag@mail.gmail.com>
References: <1357668987-3610-1-git-send-email-josh.coombs@gmail.com>
	<20130108190657.GW5075@titan.lakedaemon.net>
	<CAMW5UfY2vKEJ7K8tLJ1+JeKsr_hxtUTva9HGJxLan6k+KGdmvg@mail.gmail.com>
	<20130108200350.GX5075@titan.lakedaemon.net>
	<A874F61F95741C4A9BA573A70FE3998F69E12010@DQHE02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:59617 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab3AIQT0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2013 11:19:26 -0500
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F69E12010@DQHE02.ent.ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Kim, Milo" <Milo.Kim@ti.com>
Cc: Jason Cooper <jason@lakedaemon.net>, "cooloney@gmail.com" <cooloney@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>

I'm testing a revised version of this patch that renames the trigger
to just 'disk' and updates all documentation and default_trigger
definitions to match.  I'm also registering the trigger name
'ide-disk' for now so external tools/scripts/distros won't break while
a depreciation time is chosen.

Once I've verified this behaves on my system, I'm assuming a patch
that touches 25 files should be broken up?  I'm thinking of submitting
in the following chunks:

ledtrig-ide-disk to ledtrig-disk
documentation updates
default-trigger updates
Marvell SATA adjusted to call the trigger

Any objections or comments on this plan of attack?

Josh C

On Tue, Jan 8, 2013 at 8:29 PM, Kim, Milo <Milo.Kim@ti.com> wrote:
>> -----Original Message-----
>> From: linux-leds-owner@vger.kernel.org [mailto:linux-leds-
>> owner@vger.kernel.org] On Behalf Of Jason Cooper
>> Sent: Wednesday, January 09, 2013 5:04 AM
>> To: Josh Coombs
>> Cc: cooloney@gmail.com; linux-kernel@vger.kernel.org; linux-
>> ide@vger.kernel.org; rpurdie@rpsys.net; linux ARM; jgarzik@pobox.com;
>> linux-leds@vger.kernel.org
>> Subject: Re: [PATCH] Allow Marvell SATA driver to work with
>> LEDS_TRIGGER_IDE_DISK
>>
>> On Tue, Jan 08, 2013 at 02:18:04PM -0500, Josh Coombs wrote:
>> > Would it make more sense to add a second trigger
>> > for SATA instead?
>>
>> I'll leave that up to the led guys, I just wanted to raise the point
>> that the driver could logically support other types of disks, and we
>> should come up with a migration path instead of adding capabilities
>> ad-hoc.
>
> I agree with Jason's suggestion. One more thing to consider.
>
> If we replace the name, 'ide-disk' or 'ide_disk' with general one,
> then we should change the value of 'default_trigger' under arch directory also.
> LED trigger works if the name is matched with trigger name of LED device.
>
> Thanks,
> Milo
