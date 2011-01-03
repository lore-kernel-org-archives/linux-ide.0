From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Mon, 3 Jan 2011 14:01:20 -0500
Message-ID: <AANLkTimDpJSHzS_nMpmN-+U+1Q0cLEWE4y18ATf_OXLY@mail.gmail.com>
References: <20110103153134.GW18831@htj.dyndns.org> <Pine.LNX.4.44L0.1101031120230.1715-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57410 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab1ACTBk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 14:01:40 -0500
Received: by iwn9 with SMTP id 9so13601775iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 11:01:40 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1101031120230.1715-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tejun Heo <tj@kernel.org>, Priyanka Gupta <ankaguptaca@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org

On Mon, Jan 3, 2011 at 11:42 AM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
> On Mon, 3 Jan 2011, Tejun Heo wrote:
>
>> > Runtime suspend should not occur unless all the child devices (i.e=
=2E,
>> > the attached drives) are already suspended. =A0This means it is no=
t
>> > necessary to synchronize any operations, since there shouldn't be =
any
>> > other accesses to the hardware going on. =A0Therefore there is no =
need to
>> > use the error handler.
>>
>> Well, it's not that simple I'm afraid. =A0EH actions are asynchronou=
s.
>> Even if all the downstream devices are suspended, PHY events can
>> happen any time and EH could be active. =A0Hmmm... a delta but it wo=
uld
>> make more sense to put only the controller into hot sleep while
>> leaving the disk alone for rotating devices.
>
> That could be done. =A0How do you tell whether a particular drive is
> rotational?
>

I don't think there is a kernel flag for it (yet).

Per ATA-8 there is flag in the identify block.

http://markmail.org/message/2vonazw4bck7nefa

As that email says, I don't know how reliable the flag is.

Greg
