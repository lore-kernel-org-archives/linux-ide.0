From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH: IDE generic tweak
Date: Wed, 13 Oct 2004 11:49:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041013154916.GA6832@havoc.gtf.org>
References: <1097677476.4764.9.camel@localhost.localdomain> <20041013153152.GA5458@havoc.gtf.org> <1097678363.4696.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269370AbUJMPwe@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1097678363.4696.16.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@linux.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Oct 13, 2004 at 03:39:33PM +0100, Alan Cox wrote:
> On Mer, 2004-10-13 at 16:31, Jeff Garzik wrote:
> > > Comments ?
> > 
> > nVidia and others have been pushing for a similar module for libata...
> > at least make sure one doesn't preclude the other.
> 
> libata can't do ATAPI and doesn't know about PATA errata so it's not
> useful in libata yet.

The people requesting the feature quite disagree :)

nVidia for example specifically wanted it because future __SATA__
hardware will appear at the legacy IDE addresses, and end users were
requesting for similar reasons.

They have configurations both today and in the future where they want to
use this in libata.

	Jeff
