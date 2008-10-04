From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: #tj-upstream build fails because system_entering_hibernation is not exported
Date: Sun, 5 Oct 2008 00:24:31 +0200
Message-ID: <200810050024.31789.rjw@sisk.pl>
References: <48E7D49D.4080808@kernel.org> <48E7D72C.9080307@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45484 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753660AbYJDWUd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 18:20:33 -0400
In-Reply-To: <48E7D72C.9080307@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Saturday, 4 of October 2008, Tejun Heo wrote:
> Tejun Heo wrote:
> > Hello, Rafael.
> > 
> > #tj-upstream fails to build with the following message.
> > 
> > ERROR: "system_entering_hibernation" [drivers/ata/libata.ko] undefined!
> 
> Okay, I just added EXPORT_SYMBOL_GPL() right below the function body and
> rebased #tj-upstream.  Is that okay?

Yes, it is, thanks for fixing.

I wonder why it didn't show up for me, though.  Most likely, because I tend to
compile libata in.

[Note to self: test allmodconfig compilation sometimes.]

Rafael
