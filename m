From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] 2.6.37-rc5, pata_atiixp, DVD-ROM: kernel log flooded with "rpm_resume flags 0x4", "rpm_resume returns 1"
Date: Sat, 18 Dec 2010 23:41:04 +0100
Message-ID: <201012182341.04947.rjw@sisk.pl>
References: <20101217211556.2789cb80@stein> <Pine.LNX.4.44L0.1012181259080.3334-100000@saphir.localdomain> <20101218200837.03a23f62@stein>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37839 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab0LRWmF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Dec 2010 17:42:05 -0500
In-Reply-To: <20101218200837.03a23f62@stein>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, December 18, 2010, Stefan Richter wrote:
> On Dec 18 Alan Stern wrote:
> > On Fri, 17 Dec 2010, Stefan Richter wrote:
> > > On Dec 11 Rafael J. Wysocki wrote:
> > > > I guess you have either CONFIG_PM_VERBOSE set or CONFIG_PM_DEBUG unset.
> > > > 
> > > > Which is the case?
> > > 
> > > I have both options off on 2.6.36 and older kernels.  I have both
> > > options on on 2.6.37-rc5/-rc6 (because I wanted to check something
> > > unrelated on 2.6.37).
> > 
> > These messages are produced by dev_dbg() calls.  The debug output is 
> > enabled by either CONFIG_PM_VERBOSE or CONFIG_DEBUG_DRIVER.  Since you say 
> > CONFIG_PM_VERBOSE is off, the other must be on -- unless maybe you have 
> > CONFIG_DYNAMIC_DEBUG enabled.
> 
> No, CONFIG_PM_VERBOSE is of course _on_ in the kernel that spams the
> log.

Please turn if off, then.  Most likely you don't need it anyway.

Thanks,
Rafael
