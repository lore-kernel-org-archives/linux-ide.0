From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] pci: VT3336 can't do MSI either
Date: Wed, 25 Jun 2008 14:12:53 -0700
Message-ID: <200806251412.53453.jbarnes@virtuousgeek.org>
References: <48608792.7090909@kernel.org> <20080623225302.ab7b35de.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754082AbYFYVNT@vger.kernel.org>
In-Reply-To: <20080623225302.ab7b35de.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: linux-ide@vger.kernel.org

On Monday, June 23, 2008 10:53 pm Andrew Morton wrote:
> On Tue, 24 Jun 2008 14:35:14 +0900 Tejun Heo <tj@kernel.org> wrote:
> > It seems VT3336 can't do msi either as with its bro 3351.  Disable it.
> > Reported in the following SUSE bug.
> >
> >   https://bugzilla.novell.com/show_bug.cgi?id=300001
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
>
> (argh.  Is that permanent(ish)?)
>
> > ---
> > Anyone interested in queuing this for -rc8?  Thanks.
>
> Strictly a Jesse thing I guess, but I can do it ujnless there be
> objections.

Yeah, no objections here.  Thanks.

Jesse
