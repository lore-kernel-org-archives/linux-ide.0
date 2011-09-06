From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC PATCH #upstream-fixes] libata: don't use 32bit PIO for
 small transfers
Date: Tue, 6 Sep 2011 10:49:52 +0100
Message-ID: <20110906104952.0c930a93@bob.linux.org.uk>
References: <20110906042101.GE18425@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3042 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299Ab1IFJnu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Sep 2011 05:43:50 -0400
In-Reply-To: <20110906042101.GE18425@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, tom.leiming@gmail.com, seth.heasley@intel.com

On Tue, 6 Sep 2011 13:21:01 +0900
Tejun Heo <tj@kernel.org> wrote:

> Some configurations have problems with using 32bit PIO on ATAPI cdb
> transfers.  The most likely cause is different division of payload
> across FISes but hasn't been confirmed.  There isn't much to be gained
> by using 32bit PIO for small transfers.  Play it safe and use 16bit
> PIO for transfers smaller than 512 bytes.

This seems to me to be the wrong approach as it hurts lots of other
commands unnecessarily and may cause regressions on other setups
because their behaviour is unnecessarily changed and performance
reduced.

The problem report is specific to Sandybridge in IDE mode, which is a
recent controller so it should be chased up with the Intel folks who
submitted the device ID as an apparent hardware problem - that way if
it is a chipset problem (and I have no idea if it is) it might get a
proper workaround, or fixed in future.

Secondly it's a SATA specific problem.

Thirdly we've been doing 32bit PIO on old IDE since it was invented.

This seems an extreme reaction for a report of a single specific
problem on a single specific device and controller.

So NACK.

Add a piix_sata_data_xfer32_maybe() function to the ata_piix driver
specifically for this chipset.


I've added Seth who submitted the relevant PCI identifers to the email.
I'm a bit at a loss to understand why none of the previous discussion
or patch was Cc'd in his direction ?

Seth - the bug report is
https://bugzilla.kernel.org/show_bug.cgi?id=40592

and I guess the underlying question is "Are there any known 32bit PIO
errata that would explain this ?"

Before the changes go in it might also be worth testing CD burning and
audio ripping etc to see if the problem is one dependent on transfer
size or the fact the transfer is the cdb on a SATA transfer, so that
any fixing is done right.

Alan
