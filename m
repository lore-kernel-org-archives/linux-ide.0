From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 11:09:59 +0100
Message-ID: <20100819110959.40312e58@linux.intel.com>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
	<4C6AB68D.8000102@kernel.org>
	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>
	<4C6AB919.7060203@kernel.org>
	<20100817180158.179e7780@lxorguk.ukuu.org.uk>
	<4C6ABFFA.2000502@kernel.org>
	<20100817192353.3529733c@lxorguk.ukuu.org.uk>
	<4C6B7B72.4090405@kernel.org>
	<20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>
	<4C6BE9C8.4030803@kernel.org>
	<20100818161521.430ba361@lxorguk.ukuu.org.uk>
	<4C6CFB63.2070001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41977 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab0HSKsH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2010 06:48:07 -0400
In-Reply-To: <4C6CFB63.2070001@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jeff@garzik.org

> > Sure - but if ata_generic is already compiled in or already loaded ?
> 
> Well, what if pata_acpi is already compiled in or already loaded?  Or

Yes I am aware that one also has problems but unlike IDER I don't see a
cure.

> what if ata_piix is already compiled in or already loaded but ahci is
> not for an ich6 controller?  We have priorities in the drivers, if the
> user/admin wants to use the lower priority ones that much, he/she
> shall.  This isn't an issue.  There's no way to hotplug intel IDEs
> anyway.

The PIIX4 in the IBM docking stations is hot plug - and its why I also
have to check 0x40 and write it if zero. So the case exists.

Alan
