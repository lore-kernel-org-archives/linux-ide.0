From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Sil3114 and Hitachi disks
Date: Mon, 27 Dec 2004 08:31:50 -0500
Message-ID: <20041227133150.GA18020@havoc.gtf.org>
References: <Pine.LNX.4.44.0412241621210.16199-100000@kenzo.iwr.uni-heidelberg.de> <Pine.LNX.4.44.0412241822560.16199-100000@kenzo.iwr.uni-heidelberg.de> <20041225044658.GB25088@havoc.gtf.org> <Pine.LNX.4.58.0412271405410.31364@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([63.115.148.101]:49129 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261894AbUL0Nby (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Dec 2004 08:31:54 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412271405410.31364@dingo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org

On Mon, Dec 27, 2004 at 02:23:56PM +0100, Bogdan Costescu wrote:
> I would like to get the RHEL3 kernels to behave. Both libata and

RHEL3 is a bit behind the times.  In particular it needs one hotfix for
all swiotlb platforms (includes Intel's EM64T).  The next update will
have it, but the current one does not.


> sata_sil seem to be the same version in the RHEL3 and FC3 kernels, so
> I gather this would be more of a IOMMU problem than a SATA problem. Am
> I interpreting things correctly ? If so, I'll file a report in Red
> Hat's buzgilla.

Lack-of-an-IOMMU problem actually :)

	Jeff



