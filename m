From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 14:31:29 +0000
Message-ID: <20091119143129.0fe41623@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<20091118184125.623e063d@lxorguk.ukuu.org.uk>
	<200911182007.07405.bzolnier@gmail.com>
	<200911182056.16517.bzolnier@gmail.com>
	<20091119140259.2fee86e2@lxorguk.ukuu.org.uk>
	<4B05533A.7020508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35606 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752794AbZKSO3x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 09:29:53 -0500
In-Reply-To: <4B05533A.7020508@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

>     Point out the breakage please. The driver has been developed and tested 
> on non-x86 machine with 66 MHz PCI.

static int init_chipset_hpt366(struct pci_dev *dev)

        if (chip_type >= HPT370) {

               if ((temp & 0xFFFFF000) != 0xABCDE000) {

it then falls through and gets a 33MHz answer from the tests.


If I stash the MHz answer from boot then it works. So I imagine the boot
time value just needs to be dumped into a static for resume to use.

Alan
