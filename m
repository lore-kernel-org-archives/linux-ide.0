From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Mon, 26 May 2008 23:08:54 -0400
Message-ID: <20080527030854.GC7515@mit.edu>
References: <20080508161008.59361de5@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.church-of-our-saviour.org ([69.25.196.31]:35456 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756178AbYE0Kf0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 May 2008 06:35:26 -0400
Content-Disposition: inline
In-Reply-To: <20080508161008.59361de5@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 08, 2008 at 04:10:08PM -0700, Kristen Carlson Accardi wrote:
> power off unused ports
> 
> If the port isn't either a drive bay or an external SATA port, do not 
> keep the phy powered on if the port is unoccupied. This saves .75 watts
> on most laptops.  A module parameter can be used to override this 
> behavior and allow the phy's to be powered up regardless of whether it
> has externally accessible SATA ports. 
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Hi,

I'm wondering what's the status of this patch?  

if this has hit a subsystem tree yet?  0.75 watts power savings sounds
really cool, but it doesn't seem to be in Linus's mainline yet.  Has
it hit a subsystem tree yet, or is there some issue that still needs
to be resolved before it can go it?

Thanks, regards,

							- Ted
