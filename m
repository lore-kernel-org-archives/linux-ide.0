From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: IDE generic tweak
Date: Wed, 13 Oct 2004 15:39:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1097678363.4696.16.camel@localhost.localdomain>
References: <1097677476.4764.9.camel@localhost.localdomain>
	 <20041013153152.GA5458@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269276AbUJMPmO@vger.kernel.org>
In-Reply-To: <20041013153152.GA5458@havoc.gtf.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@linux.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mer, 2004-10-13 at 16:31, Jeff Garzik wrote:
> > Comments ?
> 
> nVidia and others have been pushing for a similar module for libata...
> at least make sure one doesn't preclude the other.

libata can't do ATAPI and doesn't know about PATA errata so it's not
useful in libata yet. The generic grabber will honour pci and io
resource allocations so the existing "borrow 0x170" stuff will do the
right thing.
