From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: No NCQ support on X61s Ultrabay?  (Intel ICH8 SATA controller
 question)
Date: Thu, 30 Apr 2009 14:47:02 +0100
Message-ID: <20090430144702.46415b90@lxorguk.ukuu.org.uk>
References: <E1LzLgA-0004j6-9W@closure.thunk.org>
	<49F90CA2.4080602@garzik.org>
	<20090430083309.437f9248@lithium.local.net>
	<49F95719.10701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762867AbZD3Nsc@vger.kernel.org>
In-Reply-To: <49F95719.10701@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alex Buell <alex.buell@munted.org.uk>, Jeff Garzik <jeff@garzik.org>, Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@linux.intel.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> So, at the point of driver load, there just isn't much we can do about
> the missing ABAR.  It's sad.  Dunno why some laptop manufacturers
> still program the thing into piix mode.  :-(

Forcing out of PIIX mode would need to go into the PCI quirks and be a
boot option not a module one - at that point its doable as a header quirk.
