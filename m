From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] IDE: fix PCI must_checks
Date: Thu, 5 Apr 2007 13:03:30 -0700
Message-ID: <20070405130330.f5f8a2a6.akpm@linux-foundation.org>
References: <20070404213704.224128ec.randy.dunlap@oracle.com>
	<20070405121302.1206e748@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:49736 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767274AbXDEUDm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Apr 2007 16:03:42 -0400
In-Reply-To: <20070405121302.1206e748@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, ide <linux-ide@vger.kernel.org>, bzolnier@gmail.com

On Thu, 5 Apr 2007 12:13:02 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Wed, 4 Apr 2007 21:37:04 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > Check PCI interface function results for errors in drivers/ide/pci.
> > 
> > drivers/ide/pci/cs5530.c:244: warning: ignoring return value of 'pci_set_mwi', declared with attribute warn_unused_result
> 
> NAK (again) 

Disagree.

> The bug is in pci_set_mwi, it should not force return value checking.
> Please fix that instead.

You don't describe your reasoning, but I will assume that it is as follows:

pci_set_mwi() is an advisory thing, and on certain platforms it might fail
to set the cacheline size to the desired number.  This is not a fatal error
and the driver can successfully run at a lesser performance level.

If that description is accurate then I'd contend that pci_set_mwi() is
misdesigned.  It should not be returning a negative error code for
something which is not an error.

The changes we should make are

a) rename pci_set_pwi() to pci_try_set_mwi()

b) make pci_try_set_mwi() return a positive, non-zero code when the
   attempt to set the cacheline size failed.  And make it return a
   negative error code when fatal errors occur.

This way

a) drivers which _do_ care about whether or not the cacheline size was
   set successfully can test for it or generate warnings and

b) we can tell when pci_try_set_mwi() encountered a fatal error for
   other reasons.


Now this may all sound excessively anal, but it is simply the correct design.
And one of the reasons for adding the __must_check annotation is to weed out
design errors.  Simply turning the thing off is a step backwards.

And we *need* to be excessively anal in the PCI setup code.  We have metric
shitloads of bugs due to problems in that area, and the more formality and
error handling and error reporting we can get in there the better off we
will be.


