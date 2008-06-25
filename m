From: Tejun Heo <tj@kernel.org>
Subject: Re: Do SATA Tapes work on *any* SATA controller?
Date: Wed, 25 Jun 2008 20:59:59 +0900
Message-ID: <4862333F.6020201@kernel.org>
References: <m1KB9va-003v2oa@lls.lls.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46957 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbYFYMAZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jun 2008 08:00:25 -0400
In-Reply-To: <m1KB9va-003v2oa@lls.lls.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell Brown <russell@lls.lls.com>
Cc: linux-ide@vger.kernel.org

Russell Brown wrote:
> Executive Summary: Do SATA Tape drives work at all?
> 
> 
> Ages past (March 28th) I posted to this list about my problems with Sony
> AIT tape drives on a nVidia MCP55 SATA controller (using sata_nv).
> 
> I never did get them working so I've just bought a Silicon Image PCI SiI
> 3512 SATA controller (using the sata_sil driver) to see if it might
> work.
> 
> Sadly it doesn't and I still can't write tapes on a SATA drive with
> Linux 2.6.25.1.
> 
> So before I put my SATA Tape drives in the bin, bite the bullet and
> purchase SCSI versions and SCSI controllers I thought I'd ask if the
> list knew of *any* SATA controller that works with tape drives in Linux?
> 
> Anyone? At all?

Albert Lee worked on tape drive support a while ago and ISTR he got a
few devices working.  I'm interested.  Are you willing to ship the drive
to me?  I can pay via paypal unless it's too expensive.

Thanks.

-- 
tejun
