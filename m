From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: disable ATAPI AN by default
Date: Wed, 19 May 2010 18:53:15 +0200
Message-ID: <4BF4177B.2040108@kernel.org>
References: <20100517225405.GA19825@cpu18.student.cs> <20100518132519.GA19658@elliptictech.com> 	<AANLkTimq8xS00gKHjjWh4OKQ2u01OutzCHqb_NgCLojx@mail.gmail.com> 	<20100518162350.GA29594@elliptictech.com> <AANLkTimgcvrTQWxwldVPfb0xGm2oa6vznJcZcDydIBBk@mail.gmail.com> 	<4BF2D8E8.1040602@kernel.org> <AANLkTikJhC3g6aOkKzSGNybNP7s8ODrWBsQ29Lgw9On1@mail.gmail.com> 	<4BF2DC55.5010209@kernel.org> <AANLkTimrKbTObcNwZmiYitAXqoqMERYHO9GTRP_FQCfr@mail.gmail.com> 	<20100518192300.GA30821@elliptictech.com> <AANLkTilvhCvaDWXMYbQF5vMLDIv58rY__i7nwclNyo2K@mail.gmail.com> <4BF3E64D.2040003@kernel.org> <4BF3E9F2.9050608@kernel.org> <4BF40E6C.6020701@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <4BF40E6C.6020701@garzik.org>
Sender: linux-hotplug-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Kay Sievers <kay.sievers@vrfy.org>, Nick Bowler <nbowler@elliptictech.com>, David Zeuthen <david@fubar.dk>, linux-hotplug@vger.kernel.org, stable@kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On 05/19/2010 06:14 PM, Jeff Garzik wrote:
> Windows completely disables AN?
> 
> Or do we simply need to be less naive about _delivery_ of AN's?

I think we first need to verify what the event is about before
delivering it to userland; IOW, it should kick a full polling op.  The
problem is the same with periodic polling.  Windows does it with
single command but we can't do that from userland as open() involves
issuing more commands.  That discrepancy is basically we're having all
these problems with periodic polling and AN infinite looping.

Hardware vendors don't consider cases where their devices are hit with
a series of commands periodically or after raising an AN event.  We
have quite a few drives which just die after being hit repeatedly with
media presence polling commands and this one is causing infinite loop
by re-raising AN.

So, until we can replicate the windows behavior (which actually is
pretty reasonable - just use single GET_CONFIGURATION call for polling
and status check), I think it's wiser to disable AN.

Thanks.

-- 
tejun
