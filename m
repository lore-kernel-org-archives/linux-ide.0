From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH: IDE generic tweak
Date: Wed, 13 Oct 2004 11:31:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041013153152.GA5458@havoc.gtf.org>
References: <1097677476.4764.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269146AbUJMPeY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1097677476.4764.9.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@linux.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Oct 13, 2004 at 03:24:48PM +0100, Alan Cox wrote:
> This allows the user to force ide-generic to claim any remaining
> IDE_STORAGE_CLASS devices. It isnt a good default to turn on because of
> loadable driver modules and confusion with SATA however it is very
> useful faced with a mainboard device that isn't supported any other way.
> Note that the entry has to come last - if it looks OK I'll comment that
> a bit more and update the option docs.
> 
> Comments ?

nVidia and others have been pushing for a similar module for libata...
at least make sure one doesn't preclude the other.

	Jeff
