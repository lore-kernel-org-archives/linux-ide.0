From: Tejun Heo <tj@kernel.org>
Subject: Re: boot failure with 4.13.0-rc6 due to ATA errors
Date: Tue, 29 Aug 2017 08:55:05 -0700
Message-ID: <20170829155505.GR491396@devbig577.frc2.facebook.com>
References: <3117ae58-d432-101e-3f0b-68d72fdee28b@gmail.com>
 <20170828195916.GA491396@devbig577.frc2.facebook.com>
 <37033f6d-2ad0-7817-10b5-cbd7ff565624@gmail.com>
 <20170828212225.GB491396@devbig577.frc2.facebook.com>
 <20170829124206.GA26738@lst.de>
 <a5caf398-3ae3-4585-23d2-b2afbbc28d7d@gmail.com>
 <20170829153037.GN491396@devbig577.frc2.facebook.com>
 <20170829155102.vgbzyh7fhjrurdhl@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37956 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdH2PzJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2017 11:55:09 -0400
Content-Disposition: inline
In-Reply-To: <20170829155102.vgbzyh7fhjrurdhl@khazad-dum.debian.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: David Ahern <dsahern@gmail.com>, Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>

Hello, Henrique.

On Tue, Aug 29, 2017 at 12:51:02PM -0300, Henrique de Moraes Holschuh wrote:
> > > > ATA-8 and later mirrors the TRUSTED COMPUTING SUPPORTED bit in word 48 of
> > > > the IDENTIFY DEVICE data.  Check this before issuing a READ LOG PAGE
> > > > command to avoid issues with buggy devices.  The only downside is that
> > > > we can't support Security Send / Receive for a device with an older
> > > > revision due to the conflicting use of this field in earlier
> > > > specifications.
> > 
> > Christoph, I'm gonna revert the horkage patch and apply this one.  If
> > you can think of a better way to do this, please let me know.
> 
> The one thing that comes to mind would be an additional patch to allow
> people with ATA-7 to bypass the identify device data, and rely just on
> the read log page check, based on a kernel command line parameter.
> 
> If we get enough sucessful reports to make it worth it, an whitelist
> could be added...

If the ones we miss are the ones based on old revisions, does it
matter?  If we have to, we can just whitelist those devices and I
don't expect there to be many.

Thanks.

-- 
tejun
