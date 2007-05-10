From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/7] libata: check for AN support
Date: Wed, 9 May 2007 22:25:48 -0700
Message-ID: <20070509222548.0c878055.akpm@linux-foundation.org>
References: <20070510072247.063476979@intel.com>
	<20070509163809.7b0b3fde.kristen.c.accardi@intel.com>
	<20070509220952.5fa34822.akpm@linux-foundation.org>
	<4642AA3E.4090308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <4642AA3E.4090308@garzik.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com, "Randy.Dunlap" <rdunlap@xenotime.net>
List-Id: linux-ide@vger.kernel.org

On Thu, 10 May 2007 01:14:38 -0400 Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> >> + *	@dev: Device to which command will be sent
> >> + *
> >> + *	Issue SET FEATURES - SATA FEATURES command to device @dev
> >> + *	on port @ap.
> >> + *
> >> + *	LOCKING:
> >> + *	PCI/etc. bus probe sem.
> >> + *
> >> + *	RETURNS:
> >> + *	0 on success, AC_ERR_* mask otherwise.
> >> + */
> > 
> > ooh, locking and return value documentation.  Often missed, and nice.
> 
> 
> We set high standards in the libata world ;-)
> 

It seems to be working.  This series is perhaps the most idiomatic and
generally kernelly-looking code I've seen in ages.

Who cares if it works? ;)
