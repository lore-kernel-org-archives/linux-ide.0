From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Tue, 27 May 2008 18:59:26 -0400
Message-ID: <20080527225926.GE6843@mit.edu>
References: <20080508161008.59361de5@appleyard> <20080527030854.GC7515@mit.edu> <20080527143202.4bab5bf0@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:34467 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750739AbYE0W76 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 May 2008 18:59:58 -0400
Content-Disposition: inline
In-Reply-To: <20080527143202.4bab5bf0@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 27, 2008 at 02:32:02PM -0700, Kristen Carlson Accardi wrote:
> 
> As far as I know the patch has gone nowhere.  I believe that 
> Jeff wanted something more flexible than the module parameter that
> I provided to override the BIOS options.  I am not working on this,
> I figured he had a pretty firm idea what he wanted so he was better
> equipped to write the patch.

Thanks Kristen,

Can you say which laptops you had tested this on where it saved power?
(Did you test any Thinkpads, in particular?)  I'm wondering if it's
worth trying to forward port your patch as a private mod to my kernel;
30 to 40 minutes of extra battery life is nothing to sneeze at!

						- Ted
