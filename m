From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: sata_via: SError: { UnrecovData Proto TrStaTrns }
Date: Wed, 14 Oct 2009 02:16:45 +0200
Message-ID: <m3r5t64yoi.fsf@intrepid.localdomain>
References: <m3my46yo5g.fsf@intrepid.localdomain>
	<19147.28614.505296.752363@pilspetsen.it.uu.se>
	<m3vdii51d8.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:58952 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbZJNARX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Oct 2009 20:17:23 -0400
In-Reply-To: <m3vdii51d8.fsf@intrepid.localdomain> (Krzysztof Halasa's message
	of "Wed, 14 Oct 2009 01:18:43 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>

Krzysztof Halasa <khc@pm.waw.pl> writes:

> Machine A: IXP425 (ARM) CPU, 266 MHz. 64 MB RAM - this time all RAM is
> accessible to VT6421A. PCI 33 MHz (using mini-PCI adapter). Both
> little-endian and big-endian CPU modes exhibit the problems.
>
> Machine B: AMD64 X2, 64-bit kernel, 2 GB RAM. Mini-PCI 33 MHz.

Correction, the mini-PCI adapter is used to put VT6421A card into
x86-64's normal slot of course. IXP425 only has mini-PCI slot and
doesn't need the adapter.
-- 
Krzysztof Halasa
