From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 15:24:43 +0000
Message-ID: <20091119152443.5ff3c949@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<20091119143351.1d0e2c59@lxorguk.ukuu.org.uk>
	<200911191550.25476.bzolnier@gmail.com>
	<200911191616.35033.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756839AbZKSPWq@vger.kernel.org>
In-Reply-To: <200911191616.35033.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> > If you know about other drivers still using ->pre_reset for cable detection
> > please let us know because they need fixing ASAP.
> 
> No need for it any longer.  I'll send patches later.

Works for me - not a bug fix as you make out but it's a clean up that is
worth doing.
 
Alan
