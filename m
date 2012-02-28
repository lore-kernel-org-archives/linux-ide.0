From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ahci: sata hotplug doesn't work after suspend
Date: Tue, 28 Feb 2012 19:36:01 +0800
Message-ID: <CAF1ivSYsFnYN=H8es2tXfb6R91rJsynkr4+Sf4tCmY78pbyakQ@mail.gmail.com>
References: <4F415775.7060003@suse.cz>
	<20120219211709.GA30809@homac.suse.de>
	<1329726646.3368.2.camel@minggr>
	<4F42420E.2010301@suse.cz>
	<1329964013.18070.3.camel@minggr>
	<CAF1ivSaQU1MXbExbtRkXy5YcbymCM_9DdR9d4BqMbti2rbvehg@mail.gmail.com>
	<4F4B436A.4050702@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F4B436A.4050702@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Holger Macht <holger@homac.de>, Jiri Slaby <jirislaby@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 27, 2012 at 4:48 PM, Jiri Slaby <jslaby@suse.cz> wrote:
> On 02/27/2012 02:05 AM, Lin Ming wrote:
>>>
>>> Could you please try below patch?
>>>
>>> And please also show the debug info.
>>> dmesg |grep "DEBUG: port"
>>
>>
>> Hi Jiri,
>>
>> Will you get a chance to test this patch?
>
>
> Yes, yesterday I booted a kernel with that patch, today I resumed fro=
m
> suspend. It works fine.

Jeff,

What do you think about this patch?
Need to add similar hotplugable port check for other controllers too.

Regards,
Lin Ming

>
> [ =A0 =A03.544423] DEBUG: port 0, PORT_CMD=3D0x40006
> [ =A0 =A03.544445] DEBUG: port 1, PORT_CMD=3D0x40006
> [ =A0 =A03.544467] DEBUG: port 2, PORT_CMD=3D0x40006
> [ =A0 =A03.544489] DEBUG: port 3, PORT_CMD=3D0x40006
> [ =A0 =A03.544511] DEBUG: port 4, PORT_CMD=3D0x6
> [ =A0 =A03.544532] DEBUG: port 5, PORT_CMD=3D0x6
> [ 1724.132173] DEBUG: port 0, PORT_CMD=3D0x40006
> [ 1724.132184] DEBUG: port 1, PORT_CMD=3D0x40006
> [ 1724.132194] DEBUG: port 2, PORT_CMD=3D0x40006
> [ 1724.132204] DEBUG: port 3, PORT_CMD=3D0x40006
> [ 1724.132214] DEBUG: port 4, PORT_CMD=3D0x6
> [ 1724.132222] DEBUG: port 5, PORT_CMD=3D0x6
>
>
> thanks,
> --
> js
> suse labs
