From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: disable ATAPI AN by default
Date: Wed, 19 May 2010 12:14:36 -0400
Message-ID: <4BF40E6C.6020701@garzik.org>
References: <20100517225405.GA19825@cpu18.student.cs> <20100518132519.GA19658@elliptictech.com> 	<AANLkTimq8xS00gKHjjWh4OKQ2u01OutzCHqb_NgCLojx@mail.gmail.com> 	<20100518162350.GA29594@elliptictech.com> <AANLkTimgcvrTQWxwldVPfb0xGm2oa6vznJcZcDydIBBk@mail.gmail.com> 	<4BF2D8E8.1040602@kernel.org> <AANLkTikJhC3g6aOkKzSGNybNP7s8ODrWBsQ29Lgw9On1@mail.gmail.com> 	<4BF2DC55.5010209@kernel.org> <AANLkTimrKbTObcNwZmiYitAXqoqMERYHO9GTRP_FQCfr@mail.gmail.com> 	<20100518192300.GA30821@elliptictech.com> <AANLkTilvhCvaDWXMYbQF5vMLDIv58rY__i7nwclNyo2K@mail.gmail.com> <4BF3E64D.2040003@kernel.org> <4BF3E9F2.9050608@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <4BF3E9F2.9050608@kernel.org>
Sender: linux-hotplug-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Kay Sievers <kay.sievers@vrfy.org>, Nick Bowler <nbowler@elliptictech.com>, David Zeuthen <david@fubar.dk>, linux-hotplug@vger.kernel.org, stable@kernel.org
List-Id: linux-ide@vger.kernel.org

On 05/19/2010 09:38 AM, Tejun Heo wrote:
> There are ATAPI devices which raise AN when hit by commands issued by
> open().  This leads to infinite loop of AN ->  MEDIA_CHANGE uevent ->
> udev open() to check media ->  AN.
>
> Both ACS and SerialATA standards don't define in which case ATAPI
> devices are supposed to raise or not raise AN.  They both list media
> insertion event as a possible use case for ATAPI ANs but there is no
> clear description of what constitutes such events.  As such, it seems
> a bit too naive to export ANs directly to userland as MEDIA_CHANGE
> events without further verification (which should behave similarly to
> windows as it apparently is the only thing that some hardware vendors
> are testing against).

Windows completely disables AN?

Or do we simply need to be less naive about _delivery_ of AN's?

	Jeff




