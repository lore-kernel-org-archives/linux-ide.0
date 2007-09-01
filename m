From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] drivers/firmware: const-ify DMI API and internals
Date: Sat, 1 Sep 2007 18:33:08 +0200
Message-ID: <200709011833.08581.ak@suse.de>
References: <20070901142719.GA31990@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:53470 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573AbXIAQdN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Sep 2007 12:33:13 -0400
In-Reply-To: <20070901142719.GA31990@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, len.brown@intel.com, linux-ide@vger.kernel.org, dz@debian.org, minyard@acm.org, j.w.r.degoede@hhs.nl, lm-sensors@lm-sensors.org, rlove@rlove.org, bzolnier@gmail.com, dmitry.torokhov@gmail.com, mzxreary@0pointer.de, stelian@popies.net, ibm-acpi@hmh.eng.br, ambx1@neo.rr.com, gimli@dark-green.com


>     And if we're really lucky, this might enable some additional
>     optimizations on the part of the compiler.

Only if the kernel was compiled C++. C compilers generally ignore constness
for optimization purposes because it can be so easily casted away.

-Andi
