From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: sil24 vs. noapic: what does this mean?
Date: Wed, 20 Sep 2006 19:30:45 +1000
Message-ID: <45110A45.90701@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from customer-domains.icp-qv1-irony8.iinet.net.au ([203.59.1.133]:15451
	"EHLO customer-domains.icp-qv1-irony8.iinet.net.au")
	by vger.kernel.org with ESMTP id S1750813AbWITJat (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Sep 2006 05:30:49 -0400
Received: from [192.168.3.7] (e7.eyal.emu.id.au [192.168.3.7])
	by e4.eyal.emu.id.au (8.11.6/8.11.6) with ESMTP id k8K9UjP31342
	for <linux-ide@vger.kernel.org>; Wed, 20 Sep 2006 19:30:45 +1000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: list linux-ide <linux-ide@vger.kernel.org>

At the office we are testing a new mobo and initially used the onboard
SATA controllers (an sata_nv and sil24).

Disks are Seagate Barracuda ES 750GB on Asus P5N-SLI-SE-DELUXE mobo.

We get regular failures on the sil24 attached disks. Changing power supply
had no effect. We then booted with 'noapic' and not a single error today.

The errors are of this type (sorry, no logs were kept)
	status=0x50 { DriveReady SeekComplete }

They arrive often and do not seem to relate so specific disk activity. In
this case it was a raid syncing for a few hours (naturally it never completed).

What does this indicate: A mobo problem? A bios issue? A bios setup error?
A kernel apic issue or a sil24 driver issue?

I used to get these at home when I used a sil based card (now not in use
anymore) and I consider this a common problem. I also see these mentioned
often elsewhere (as a websearch can easily confirm).

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
