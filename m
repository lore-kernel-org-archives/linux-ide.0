From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH] stop gcc warning about uninitialized 'dev' in
	ata_scsi_scan_host
Date: Wed, 15 Oct 2008 21:40:42 -0600
Message-ID: <20081016034042.GA27621@ldl.fc.hp.com>
References: <20081015232505.GB9272@ldl.fc.hp.com> <48F6A2E7.5090005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:7275 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbYJPDkn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 23:40:43 -0400
Content-Disposition: inline
In-Reply-To: <48F6A2E7.5090005@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jeff@redhat.com, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

* Tejun Heo <tj@kernel.org>:
> Alex Chiang wrote:
> > Shuts up gcc-3.4.5-glibc-2.3.6 when it complains of:
> > 
> > drivers/ata/libata-scsi.c: In function `ata_scsi_scan_host':
> > drivers/ata/libata-scsi.c:3225: warning: 'dev' might be used
> > uninitialized in this function
> > 
> > Signed-off-by: Alex Chiang <achiang@hp.com>
> 
> Nacked-by: Tejun Heo <tj@kernel.org>
> 
> Some gcc versions complain about sata_via, others complain
> about something else.  Some versions complain about some
> iterator usages while not complaining about others, but none of
> those complaints is actually wrong or dangerous.  I don't think
> adding = NULL whenever some version of gcc complains is the
> right approach.

Hm, ok.

I guess we don't want to sprinkle these around all over the place
just to solve cosmetic issues, which makes sense, but is there
some other approach we could take instead? Any suggestions? Or
just live with it?

/ac

