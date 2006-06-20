From: Bastiaan Jacques <b.jacques@planet.nl>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using ahci module
Date: Tue, 20 Jun 2006 21:31:12 +0200
Message-ID: <200606202131.12654.b.jacques@planet.nl>
References: <1149787827.4180.8.camel@anja> <200606201721.26291.boac@wanadoo.nl>
 <4498163C.90601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp16.wxs.nl ([195.121.247.7]:64473 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S1750799AbWFTTax (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 15:30:53 -0400
Received: from elysium.bjacques.org (ip56538861.direct-adsl.nl [86.83.136.97])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0J1600EMMBJGPT@smtp16.wxs.nl> for linux-ide@vger.kernel.org;
 Tue, 20 Jun 2006 21:30:52 +0200 (CEST)
In-reply-to: <4498163C.90601@gmail.com>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: boac@wanadoo.nl, linux-ide@vger.kernel.org

On Tuesday 20 June 2006 17:37, Tejun Heo wrote:
> [CC'ing Bastiaan Jacques. Hi!]

Hey!

> Do you happen to have a different drive which can do NCQ? 
> Preferably, one from another vendor?  

I've just tried it with a Maxtor drive supporting NCQ, and it didn't 
work.

> AFAICS, the ahci driver is 
> doing NCQ as the AHCI spec specifies and all ICH controllers seem to
> be quite happy with it.  I wanna know whether the problem is from the
> specific combination of the controller and the drive or the via
> controller needs a different programming sequence for NCQ in general.

It would seem the problem is in the VIA controller. Surprise, surprise.

> Bastiaan, do you know whether we need to do things differently to use
> NCQ on vt8251?

Apparently we have a hardware or firmware bug to work around, but I have 
no idea what we should be doing differently.

-- 
Bastiaan
