From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: boot failure with 4.13.0-rc6 due to ATA errors
Date: Tue, 29 Aug 2017 12:51:02 -0300
Message-ID: <20170829155102.vgbzyh7fhjrurdhl@khazad-dum.debian.net>
References: <3117ae58-d432-101e-3f0b-68d72fdee28b@gmail.com>
 <20170828195916.GA491396@devbig577.frc2.facebook.com>
 <37033f6d-2ad0-7817-10b5-cbd7ff565624@gmail.com>
 <20170828212225.GB491396@devbig577.frc2.facebook.com>
 <20170829124206.GA26738@lst.de>
 <a5caf398-3ae3-4585-23d2-b2afbbc28d7d@gmail.com>
 <20170829153037.GN491396@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50017 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751670AbdH2PvK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2017 11:51:10 -0400
Content-Disposition: inline
In-Reply-To: <20170829153037.GN491396@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>

On Tue, 29 Aug 2017, Tejun Heo wrote:
> On Tue, Aug 29, 2017 at 09:08:05AM -0600, David Ahern wrote:
> > On 8/29/17 6:42 AM, Christoph Hellwig wrote:
> > > ---
> > > From e661047ec3a25587648b07c02a687a7dac778f3b Mon Sep 17 00:00:00 2001
> > > From: Christoph Hellwig <hch@lst.de>
> > > Date: Tue, 29 Aug 2017 14:35:50 +0200
> > > Subject: libata: check for trusted computing in IDENTIFY DEVICE data
> > > 
> > > ATA-8 and later mirrors the TRUSTED COMPUTING SUPPORTED bit in word 48 of
> > > the IDENTIFY DEVICE data.  Check this before issuing a READ LOG PAGE
> > > command to avoid issues with buggy devices.  The only downside is that
> > > we can't support Security Send / Receive for a device with an older
> > > revision due to the conflicting use of this field in earlier
> > > specifications.
> 
> Christoph, I'm gonna revert the horkage patch and apply this one.  If
> you can think of a better way to do this, please let me know.

The one thing that comes to mind would be an additional patch to allow
people with ATA-7 to bypass the identify device data, and rely just on
the read log page check, based on a kernel command line parameter.

If we get enough sucessful reports to make it worth it, an whitelist
could be added...

-- 
  Henrique Holschuh
