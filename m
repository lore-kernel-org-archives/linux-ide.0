From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC PATCH #upstream-fixes] libata: don't use 32bit PIO for
 small transfers
Date: Wed, 14 Sep 2011 19:51:56 +0100
Message-ID: <20110914195156.37ae9db4@bob.linux.org.uk>
References: <20110906042101.GE18425@mtj.dyndns.org>
	<20110906104952.0c930a93@bob.linux.org.uk>
	<CACVXFVO0LzxSj=7Q054gcK5x9fDuNniE0GteKmpYNOXWAc-0gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25448 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757306Ab1INSpB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Sep 2011 14:45:01 -0400
In-Reply-To: <CACVXFVO0LzxSj=7Q054gcK5x9fDuNniE0GteKmpYNOXWAc-0gw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, seth.heasley@intel.com

On Wed, 14 Sep 2011 15:44:43 +0800
Ming Lei <tom.leiming@gmail.com> wrote:

> Hi Tejun and Alan,
> 
> Thanks for your spending time on the bug.
> 
> On Tue, Sep 6, 2011 at 5:49 PM, Alan Cox <alan@linux.intel.com> wrote:
> 
> >
> > So NACK.
> >
> > Add a piix_sata_data_xfer32_maybe() function to the ata_piix driver
> > specifically for this chipset.
> 
> Could you accept the quirk patch below to make these controllers
> working at least now?

To me that looks like the right fix. It affects the minimum amount of
hardware. It uses the standard operations in full and it documents
clearly what it is doing.

Alan
