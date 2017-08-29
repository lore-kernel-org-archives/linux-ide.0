From: Tejun Heo <tj@kernel.org>
Subject: Re: boot failure with 4.13.0-rc6 due to ATA errors
Date: Tue, 29 Aug 2017 08:38:29 -0700
Message-ID: <20170829153829.GO491396@devbig577.frc2.facebook.com>
References: <3117ae58-d432-101e-3f0b-68d72fdee28b@gmail.com>
 <20170828195916.GA491396@devbig577.frc2.facebook.com>
 <37033f6d-2ad0-7817-10b5-cbd7ff565624@gmail.com>
 <20170828212225.GB491396@devbig577.frc2.facebook.com>
 <20170829124206.GA26738@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34670 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbdH2Pid (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2017 11:38:33 -0400
Content-Disposition: inline
In-Reply-To: <20170829124206.GA26738@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: David Ahern <dsahern@gmail.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>

On Tue, Aug 29, 2017 at 02:42:06PM +0200, Christoph Hellwig wrote:
> From e661047ec3a25587648b07c02a687a7dac778f3b Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 29 Aug 2017 14:35:50 +0200
> Subject: libata: check for trusted computing in IDENTIFY DEVICE data
> 
> ATA-8 and later mirrors the TRUSTED COMPUTING SUPPORTED bit in word 48 of
> the IDENTIFY DEVICE data.  Check this before issuing a READ LOG PAGE
> command to avoid issues with buggy devices.  The only downside is that
> we can't support Security Send / Receive for a device with an older
> revision due to the conflicting use of this field in earlier
> specifications.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to libata/for-4.13-fixes.

Thanks.

-- 
tejun
