From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Date: Wed, 31 Jan 2007 15:21:36 -0800
Message-ID: <20070131152136.7d0a05ff.kristen.c.accardi@intel.com>
References: <15F501D1A78BD343BE8F4D8DB854566B0CEB90E0@hkemmail01.nvidia.com>
	<455DF9AE.3000406@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34995 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160998AbXAaXV4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 18:21:56 -0500
In-Reply-To: <455DF9AE.3000406@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Peer Chen <pchen@nvidia.com>, Christoph Hellwig <hch@infradead.org>, Prakash Punnoor <prakash@punnoor.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

On Fri, 17 Nov 2006 13:04:30 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Peer Chen wrote:
> > I didn't get any comment from you guys for new patch, does someone take
> > care this patch, do we still need some modification upon it? Or do we
> > need re-submit it in other thread?
> 
> For my part, it's in my queue of things to review.  I need to figure out 
> the best way to export this support.
> 
> 	Jeff

Adding SGPIO support directly into an individual SATA driver seems to be
a very bad idea since SGPIO is a) a protocol that can be used by many 
different SATA controllers and is not nvidia specific and b) can also
be used by SAS.
