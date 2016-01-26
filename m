From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Tue, 26 Jan 2016 13:17:16 +0100
Message-ID: <5730117.gx9ezcyLp7@wuerfel>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com> <20160125204300.GM3628@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:57478 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933038AbcAZMRb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2016 07:17:31 -0500
In-Reply-To: <20160125204300.GM3628@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org

On Monday 25 January 2016 15:43:00 Tejun Heo wrote:
> On Thu, Jan 14, 2016 at 10:31:11AM -0600, Brijesh Singh wrote:
> > AMD Seattle SATA controller mostly conforms to AHCI interface with some
> > special register to control SGPIO interface. In the case of an AHCI
> > controller, the SGPIO feature is ideally implemented using the
> > "Enclosure Management" register of the AHCI controller, but those
> > registeres are not implemented in the Seattle SoC. Instead SoC
> > (Rev B0 onwards) provides a 32-bit SGPIO control register which should
> > be programmed to control the activity, locate and fault LEDs.
> > 
> > The driver is based on ahci_platform driver.
> > 
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
> > CC: tj@kernel.org
> > CC: linux-ide@vger.kernel.org
> 
> Hans, can you please review the patch?
> 

I think it needs more work: The changelog describes it as a normal
driver, but based on the previous discussion, this is just a hack
to work around broken BIOS versions that can no longer be fixed in
the field, and there has not been a decision what the proper
representation should be in ACPI.

The patch also fails to address the devicetree based case, even though
we did come to a conclusion that the current behavior is a regression
(compared to what we had in drivers/ide/) and that there is a relatively
simple fix to do it right.

I'd rather see this problem solved for DT first and then have a
discussion about what the ACPI binding should look like, with
a review from ACPI folks before this hack gets cemented in the kernel.

	Arnd
