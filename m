From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: System fails to connect to iHOS-104 DVD drive with nvidia MCP61 chipset.
Date: Tue, 17 Sep 2013 19:40:46 -0600
Message-ID: <CADLC3L2unM8ZfuKm3hbfo3-Wp-yTRBK79H=s-K2EaoPNv+rOUQ@mail.gmail.com>
References: <520AB4D8.1000208@1045.ca>
	<520B210B.5040700@gmail.com>
	<520C01E8.9040302@1045.ca>
	<CADLC3L1uR=+mSj5MtgK9hKPjz-wOaVsw3W6woALq6SX4vO6wJQ@mail.gmail.com>
	<520D92C6.30009@1045.ca>
	<520FB3BA.7050302@1045.ca>
	<CADLC3L27QcScLgw4CBGkQ3tG5037CAgQJRdW5384=sL8cM8a3Q@mail.gmail.com>
	<5217FFB2.4050007@1045.ca>
	<CADLC3L0wXmVDgHPOFEkeiXD9sDUBg3tZePcJ-gRfoRN5-fXE1w@mail.gmail.com>
	<52180F76.3070803@1045.ca>
	<CADLC3L2NfS7N30zqu5zPgxnh-vcEUxyWX3v4W1bUHB=G2J5m9Q@mail.gmail.com>
	<5238F554.60708@1045.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:38730 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab3IRBks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Sep 2013 21:40:48 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so6007477lbh.20
        for <linux-ide@vger.kernel.org>; Tue, 17 Sep 2013 18:40:47 -0700 (PDT)
In-Reply-To: <5238F554.60708@1045.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Link <Bruce@1045.ca>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, 1063474@bugs.launchpad.net

On Tue, Sep 17, 2013 at 6:35 PM, Bruce Link <Bruce@1045.ca> wrote:
>> Hello,
>>
>> On Fri, Sep 06, 2013 at 07:53:49PM -0600, Robert Hancock wrote:
>> > > Is there any more information I can supply that would be helpful=
?
>> >
>> > I'm not quite sure what the next step would be. It's quite possibl=
e
>> > that the NVIDIA driver in Windows is doing some magic to work arou=
nd
>> > the problem that we don't know about, but it's hard to say what th=
at
>> > might be. The fact that the default drivers used in the WinPE boot
>> > don't seem to work would tend to point toward some kind of hardwar=
e
>> > incompatibility issue.
>> >
>> > Tejun, think you poked with some of this stuff before - any ideas?
>>
>> It has been years since I looked at MCP quirks, of which there are t=
oo
>> many.  It's likely another quirk on the controller side that nvidia
>> worked around somehow without telling anyone.  Given the history and
>> that nvidia is out of chipset market, I think it's highly unlikely t=
o
>> learn what the issue and workaround are without reverse engineering
>> it.  So, um, no idea.
>>
>> Thanks.
>>
>> --
>> tejun
>> --
>
>
> Robert,
>
> I've inquired about this problem with Allen Martin at Nvidia, he had =
the
> following reply:
>
> /--------SNIP---------------/
> Hi Bruce, I did work on the Windows SATA driver for those chipsets, s=
o I=92m
> familiar with it. I=92m not aware of any of any timing workarounds fo=
r any
> devices in the driver, but it=92s certainly true that there are devic=
es that
> have timing sensitivity, especially around the IDENTIFY command and i=
t may
> inadvertently work with one driver and not another.
>
> From the bug reports it looks like it=92s always timing out on a
> TEST_UNIT_READY command? I assume this is probably the first command =
sent
> down after IDENTIFY to check for presense of a CD in the drive? If so=
 it=92s
> likely the drive is locked up and any command at that point will fail=
=2E If
> you want to test out the theory about it being a timing issue, I woul=
d stick
> some udelay()s in the identify code path, both before and after start=
ing the
> transfer to see if it makes any difference. Also do you know if the d=
river
> does a PHY reset when it resets the link? If not, you can try doing t=
hat by
> writing a 0 to SControl and then restoring it with the original value=
=2E
>
> Hope this helps,
>
> -Allen
> /--------SNIP---------------/
>
> Does this provide any actionable information? I've tried searching fo=
r the
> proper location to impliment these delays in the sata_nv.c and libata=
-eh.c
> files but admittedly, am in over my head.

Don't think there's any earth-shaking revelations but it might be a
few things to try. First, though, apparently there is a firmware
update for this drive of at least one revision up (WL0G) available
from Lite-ON that you could try updating to. (You'll likely need to
use Windows for that.) Given that it seems broken in at least two
different environments on this controller, it's possible they fixed
something related in the drive.
