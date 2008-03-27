From: David Brownell <david-b@pacbell.net>
Subject: Re: some minor issues with 2.6.25-rc6-git7-default
Date: Thu, 27 Mar 2008 12:16:18 -0700
Message-ID: <200803271216.18672.david-b@pacbell.net>
References: <213294492@web.de> <20080326131346.39efee07.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20080326131346.39efee07.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: devzero@web.de, "Rafael J. Wysocki" <rjw@sisk.pl>, alan@lxorguk.ukuu.org.uk, greg@kroah.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 26 March 2008, Randy Dunlap wrote:
> 
> > > uh, "known problem": multiple rtc drivers are being run.
> > > 
> > > I don't really understand why we haven't been able to fix this - there have
> > > been numerous reports..
> > 
> > i will take a closer look to determine how/when this happens.
> 
> I thought that David B. sent a (Kconfig ?) patch for this...

He did.  In fact, one with a weak "nudge users away from this"
and then a stronger "don't effing allow it" update.  That's all
in the MM tree.

- Dave

