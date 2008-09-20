From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4 v2] Add documentation for hard disk shockprotection
 interface
Date: Sat, 20 Sep 2008 19:25:09 -0400
Message-ID: <48D58655.5060300@kernel.org>
References: <87d4j2n3dn.fsf@denkblock.local>	<20080917163145.9870.8575.stgit@denkblock.local>	<1221724782.3261.13.camel@raz> <87iqssmpl0.fsf@denkblock.local>	<1221854586.7473.16.camel@raz> <87ej3f7pwr.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56065 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbYITX0r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Sep 2008 19:26:47 -0400
In-Reply-To: <87ej3f7pwr.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: raz ben yehuda <razb@bitband.com>, linux-ide@vger.kernel.org

Hello,

Elias Oltmanns wrote:
> Disk head parking is meant as a short term emergency resort. In general,
> it does *not* extend the lifetime of a disk. In fact, emergency head
> unloads are considered to be costly and smart even counts those events
> as an aging factor. It really is just a means to prevent even worse
> damage due to heavy shocks, nothing for regular maintenance.

Just slight clarification.  Emergency head unload has nothing much to
do with explicit head unload used for shock protection.  Emergency
head unload happens when the power is lost while the head is loaded,
that is, when the power is turned off without preceding IDLE IMMEDIATE
or STANDBYNOW.  But other than that, AFAIK, Elias's statement is
correct.  It's unclear whether unloading the head or spinning down the
drive would extend or shorten the lifetime of a disk.

-- 
tejun
