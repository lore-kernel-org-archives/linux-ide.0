From: dean gaudet <dean@arctic.org>
Subject: Re: [RFT][PATCH v7] =?utf-8?b?c2F0YV9tdjo=?= convert to new EH
Date: Thu, 6 Sep 2007 09:10:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709060858030.19388@twinlark.arctic.org>
References: <20070711200538.GA7374@havoc.gtf.org>
 <Pine.LNX.4.64.0707120212210.25837@twinlark.arctic.org> <46960225.5000502@garzik.org>
 <Pine.LNX.4.64.0707121140560.29365@twinlark.arctic.org>
 <loom.20070713T053938-434@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from twinlark.arctic.org ([207.29.250.54]:49736 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758154AbXIFQK1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 12:10:27 -0400
In-Reply-To: <loom.20070713T053938-434@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: greg <greg-dated-1184731565.7e0579@lucidsolutions.co.nz>
Cc: linux-ide@vger.kernel.org

On Fri, 13 Jul 2007, greg wrote:

> dean gaudet <dean <at> arctic.org> writes:
> > if you've got any other workload you'd like me to throw at it, 
> > let me know.  
> 
> I've had a few problems with the driver in 2.6.20 (fc6xen x86_64). The machine 
> tended to lock up after a random period of time (from a few minutes upwards), 
> without any messages. Performing a smartctl on all the disks, or leaving smartd 
> running, seemed to speed up the rate at which the crash occurred. What I found 
> was that by moving the sata_mv device onto it's own bus (or a bus with two 
> sata_mv devices), the crashes went away. Are you doing tests with the 
> controller sharing a bus with other devices?
> 
> Is there an merit to my observation that it might be an issue with devices 
> sharing a PCI-X bus?
> 
> Cards: Supermicro 5081 (SAT-MV8), Supermicro 6081 (SAT2-MV8), Highpoint 5081 
> (RocketRaid 1820A v1.1). Motherboards: Tyan S2882, AMD 8131 chipset; IBM x206, 
> Intel 6300ESB.

hmm!  i don't seem to have replied to this.

you know, i've seen this problem.  the first time it happened was with a 
promise ultra tx/100 or tx/133 (on a dual k7 box, two controllers on the 
same bus certainly)... a 5 minute cronjob logging HD temperatures via 
smart would occasionally cause one of the disks to just disappear, return 
errors on every request, and required a reboot to rediscover it.  
eliminating the cronjob stopped the problem.

i switched to 3ware 750x and the problem went away even with the cronjob 
going.

forward a few years and i ran into the same problem with a 3ware 9550sx 
(only card on the bus) -- and a firmware upgrade to the controller 
eventually fixed the problem.

but yeah, i've been meaning to add a "smartctl -a" once every 10 seconds 
to my burn-in process because of these experiences... but haven't built a 
new server in a while.

the particular box i was testing sata_mv on (tyan s2881) has every pci-x 
slot filled with one thing or another, but i only have one sata_mv device.  
if i get around to testing again i'll throw smartctl into the mix.

-dean
