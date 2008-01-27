From: "dusty@gmx.li" <dusty@gmx.li>
Subject: Re: libata pm
Date: Sun, 27 Jan 2008 19:34:35 -0000 (UTC)
Message-ID: <49713.82.140.63.93.1201462475.squirrel@ssl.cavemail.org>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>   
    <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>   
    <479BC34D.2000007@gmail.com>
    <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org>
Reply-To: dusty@gmx.li
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavemail.org ([62.75.189.85]:59546 "EHLO mail.cavemail.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759795AbYA0Tem (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Jan 2008 14:34:42 -0500
In-Reply-To: <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, dusty@gmx.li, linux-ide@vger.kernel.org

Am So, 27.01.2008, 01:38, schrieb dusty@gmx.li:
> Am Sa, 26.01.2008, 23:33, schrieb Tejun Heo:
>
>> dusty@gmx.li wrote:
>>> I could solve the problem by ncq blacklisting the "Maxtor 6V300F0"
>>> devices in libata-core.c
>>
>> That's a strange story.  The reported error was PHY readiness changed
>> and Device exchanged, both of which point to hotplug event.  Maybe
>> something causes the firmware to reset?  What happen if you only leave
>> two drives on the port multiplier and remove the NCQ blacklist?  Also,
>> does the error ever occur on the drives which are connected directly to
>> the controller?
>>
>>
>> --
>> tejun
>>
>>
>
> No the error only occures on the drives on the pm. I can test the pm with
>  two Maxtor drives tomorrow (currently backing up the raid).
>
>

With one, two and three drives on the pm I got no errors, so I tried to
change the power supply. I got two power supplies for the 16 harddrives
and the second one (with all Maxtor drives and the first pm) was failing.
After changing the power supply all problems where gone. Sorry for the
confusion.

The only remaining issue is that some sata links are only working with 1.5
gbps and I can't figure out why. (ata3,4,5,6.x are the Maxtor drives and
ata7,8,9,10.x are the Samsung ones)

jasmin ~ # dmesg | grep Gbps
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

