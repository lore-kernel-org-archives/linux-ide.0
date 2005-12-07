From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 07 Dec 2005 15:41:14 +0000
Message-ID: <1133970074.544.69.camel@localhost.localdomain>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:50348 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751149AbVLGPnD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Dec 2005 10:43:03 -0500
In-Reply-To: <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>

On Mer, 2005-12-07 at 15:45 +0100, Bartlomiej Zolnierkiewicz wrote:
> OK, I understand it now - when using 'ide-generic' host driver for IDE
> PCI device, resume fails (for obvious reason - IDE PCI device is not
> re-configured) and this patch fixes it through using ACPI methods.

Even in the piix case some devices need it because the bios wants to
issue commands such as password control if the laptop is set up in
secure modes.

