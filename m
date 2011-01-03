From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Mon, 3 Jan 2011 18:10:45 -0500
Message-ID: <AANLkTi=oQ2waA2gdVfRFCgN4zpjj2C5jT2ExPP2jntZa@mail.gmail.com>
References: <20110103153134.GW18831@htj.dyndns.org> <Pine.LNX.4.44L0.1101031120230.1715-100000@iolanthe.rowland.org>
 <AANLkTimDpJSHzS_nMpmN-+U+1Q0cLEWE4y18ATf_OXLY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49503 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab1ACXLH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 18:11:07 -0500
Received: by iyi12 with SMTP id 12so12504488iyi.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 15:11:06 -0800 (PST)
In-Reply-To: <AANLkTimDpJSHzS_nMpmN-+U+1Q0cLEWE4y18ATf_OXLY@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tejun Heo <tj@kernel.org>, Priyanka Gupta <ankaguptaca@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org, "Peter M. Petrakis" <peter.petrakis@canonical.com>

On Mon, Jan 3, 2011 at 2:01 PM, Greg Freemyer <greg.freemyer@gmail.com>=
 wrote:
> On Mon, Jan 3, 2011 at 11:42 AM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>> On Mon, 3 Jan 2011, Tejun Heo wrote:
>>
>>> > Runtime suspend should not occur unless all the child devices (i.=
e.,
>>> > the attached drives) are already suspended. =A0This means it is n=
ot
>>> > necessary to synchronize any operations, since there shouldn't be=
 any
>>> > other accesses to the hardware going on. =A0Therefore there is no=
 need to
>>> > use the error handler.
>>>
>>> Well, it's not that simple I'm afraid. =A0EH actions are asynchrono=
us.
>>> Even if all the downstream devices are suspended, PHY events can
>>> happen any time and EH could be active. =A0Hmmm... a delta but it w=
ould
>>> make more sense to put only the controller into hot sleep while
>>> leaving the disk alone for rotating devices.
>>
>> That could be done. =A0How do you tell whether a particular drive is
>> rotational?
>>
>
> I don't think there is a kernel flag for it (yet).
>
> Per ATA-8 there is flag in the identify block.
>
> http://markmail.org/message/2vonazw4bck7nefa
>
> As that email says, I don't know how reliable the flag is.
>
> Greg

Ignore my noise, as of 2.6.36 you get it via ata_id_rotation_rate().
If its set to 1, then its a SSD.

Unfortunately, needed horkage is not yet implemented.

And the 2 proposed patches I've seen to do it were in the scsi-ata
translation logic ( drivers/ata/libata-scsi.c) and not readily usable
other code directly.

Looks to me like a post_horkage_ata_id_rotation_rate() routine needs
to be created between libata-scsi and ata_id_rotation_rate().

(More in the above referenced thread if you want to follow it.)

Greg
