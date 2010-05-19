From: Nick Bowler <nbowler@elliptictech.com>
Subject: Re: [PATCH #upstream-fixes] libata: disable ATAPI AN by default
Date: Wed, 19 May 2010 12:58:40 -0400
Message-ID: <20100519165840.GA12642@elliptictech.com>
References: <20100518162350.GA29594@elliptictech.com>
 <AANLkTimgcvrTQWxwldVPfb0xGm2oa6vznJcZcDydIBBk@mail.gmail.com>
 <4BF2D8E8.1040602@kernel.org>
 <AANLkTikJhC3g6aOkKzSGNybNP7s8ODrWBsQ29Lgw9On1@mail.gmail.com>
 <4BF2DC55.5010209@kernel.org>
 <AANLkTimrKbTObcNwZmiYitAXqoqMERYHO9GTRP_FQCfr@mail.gmail.com>
 <20100518192300.GA30821@elliptictech.com>
 <AANLkTilvhCvaDWXMYbQF5vMLDIv58rY__i7nwclNyo2K@mail.gmail.com>
 <4BF3E64D.2040003@kernel.org>
 <4BF3E9F2.9050608@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl-67-204-24-19.acanac.net ([67.204.24.19]:46771 "EHLO
	emergent.ellipticsemi.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751688Ab0ESQ7K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 12:59:10 -0400
Content-Disposition: inline
In-Reply-To: <4BF3E9F2.9050608@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Kay Sievers <kay.sievers@vrfy.org>, David Zeuthen <david@fubar.dk>, linux-hotplug@vger.kernel.org, stable@kernel.org

On 15:38 Wed 19 May     , Tejun Heo wrote:
> There are ATAPI devices which raise AN when hit by commands issued by
> open().  This leads to infinite loop of AN -> MEDIA_CHANGE uevent ->
> udev open() to check media -> AN.
> 
> Both ACS and SerialATA standards don't define in which case ATAPI
> devices are supposed to raise or not raise AN.  They both list media
> insertion event as a possible use case for ATAPI ANs but there is no
> clear description of what constitutes such events.  As such, it seems
> a bit too naive to export ANs directly to userland as MEDIA_CHANGE
> events without further verification (which should behave similarly to
> windows as it apparently is the only thing that some hardware vendors
> are testing against).
> 
> This patch adds libata.atapi_an module parameter and disables ATAPI AN
> by default for now.

Works here, drive now spins down properly.

Tested-By: Nick Bowler <nbowler@draconx.ca>

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
