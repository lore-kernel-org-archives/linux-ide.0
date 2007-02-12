From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [Fedora-ia64-list] Re: The 5th bar of ide controller at legacy mode
Date: Mon, 12 Feb 2007 10:18:40 -0800
Message-ID: <617E1C2C70743745A92448908E030B2A011E7BEC@scsmsx411.amr.corp.intel.com>
References: <20070212125646.61263751@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5752 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964999AbXBLSSp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 13:18:45 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070212125646.61263751@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ia64 Fedora Core Development <fedora-ia64-list@redhat.com>, "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: linux-ide@vger.kernel.org

> Your platform code or BIOS is buggy. PPC people had a similar problem.
> Zero is not currently taken as "unallocated" by the PCI layer and, while
> Linus suggested it could be, Dave Woodhouse and others pointed out there
> are systems which legitimately use address 0 on the PCI in this way.

The claim from the BIOS team is that on this system only legacy mode is
supported (indicated by the Class Code Programming model being 0x8A) and
since drivers/utilities should not make assumptions about these BAR values
when the device is in legacy mode, they don't have to initialize them.
The BARS would only be guaranteed to be set when programming model 0x8F
(native mode) is set.

Which sounds sort of plausible ... but perhaps that's because I have
not idea what a "Class code programming model" is.  Does that make
any sense?

> Sounds like you need to fix up after your firmware in your boot code,
> perhaps with an arch specific pci header quirk.

If many other BIOS writers believe the same thing as ours, then maybe
it might be worth fixing ... otherwise it looks like we'll need a quirk
(this machine is old, there isn't much liklihood of an updated BIOS release
for just this issue).

-Tony
