From: Bruce Link <Bruce@1045.ca>
Subject: Re: System fails to connect to iHOS-104 DVD drive with nvidia MCP61
 chipset.
Date: Tue, 17 Sep 2013 19:35:32 -0500
Message-ID: <5238F554.60708@1045.ca>
References: <520AB4D8.1000208@1045.ca> <520B210B.5040700@gmail.com> <520C01E8.9040302@1045.ca> <CADLC3L1uR=+mSj5MtgK9hKPjz-wOaVsw3W6woALq6SX4vO6wJQ@mail.gmail.com> <520D92C6.30009@1045.ca> <520FB3BA.7050302@1045.ca> <CADLC3L27QcScLgw4CBGkQ3tG5037CAgQJRdW5384=sL8cM8a3Q@mail.gmail.com> <5217FFB2.4050007@1045.ca> <CADLC3L0wXmVDgHPOFEkeiXD9sDUBg3tZePcJ-gRfoRN5-fXE1w@mail.gmail.com> <52180F76.3070803@1045.ca> <CADLC3L2NfS7N30zqu5zPgxnh-vcEUxyWX3v4W1bUHB=G2J5m9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out-01.shaw.ca ([64.59.136.137]:44436 "EHLO
	smtp-out-01.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab3IRAfr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Sep 2013 20:35:47 -0400
In-Reply-To: <CADLC3L2NfS7N30zqu5zPgxnh-vcEUxyWX3v4W1bUHB=G2J5m9Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, 1063474@bugs.launchpad.net

> Hello,
>
> On Fri, Sep 06, 2013 at 07:53:49PM -0600, Robert Hancock wrote:
> > > Is there any more information I can supply that would be helpful?
> >
> > I'm not quite sure what the next step would be. It's quite possible
> > that the NVIDIA driver in Windows is doing some magic to work aroun=
d
> > the problem that we don't know about, but it's hard to say what tha=
t
> > might be. The fact that the default drivers used in the WinPE boot
> > don't seem to work would tend to point toward some kind of hardware
> > incompatibility issue.
> >
> > Tejun, think you poked with some of this stuff before - any ideas?
>
> It has been years since I looked at MCP quirks, of which there are to=
o
> many.  It's likely another quirk on the controller side that nvidia
> worked around somehow without telling anyone.  Given the history and
> that nvidia is out of chipset market, I think it's highly unlikely to
> learn what the issue and workaround are without reverse engineering
> it.  So, um, no idea.
>
> Thanks.
>
> --=20
> tejun
> --

Robert,

I've inquired about this problem with Allen Martin at Nvidia, he had th=
e=20
following reply:

/--------SNIP---------------/
Hi Bruce, I did work on the Windows SATA driver for those chipsets, so=20
I=92m familiar with it. I=92m not aware of any of any timing workaround=
s for=20
any devices in the driver, but it=92s certainly true that there are=20
devices that have timing sensitivity, especially around the IDENTIFY=20
command and it may inadvertently work with one driver and not another.

 From the bug reports it looks like it=92s always timing out on a=20
TEST_UNIT_READY command? I assume this is probably the first command=20
sent down after IDENTIFY to check for presense of a CD in the drive? If=
=20
so it=92s likely the drive is locked up and any command at that point w=
ill=20
fail. If you want to test out the theory about it being a timing issue,=
=20
I would stick some udelay()s in the identify code path, both before and=
=20
after starting the transfer to see if it makes any difference. Also do=20
you know if the driver does a PHY reset when it resets the link? If not=
,=20
you can try doing that by writing a 0 to SControl and then restoring it=
=20
with the original value.

Hope this helps,

-Allen
/--------SNIP---------------/

Does this provide any actionable information? I've tried searching for=20
the proper location to impliment these delays in the sata_nv.c and=20
libata-eh.c files but admittedly, am in over my head.

Thanks
Bruce




