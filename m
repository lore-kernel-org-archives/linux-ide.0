From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 0/3] Initial ZAC support
Date: Wed, 5 Nov 2014 16:03:40 +0100
Message-ID: <20141105150340.GA1326@lst.de>
References: <1415189302-108476-1-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54913 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754950AbaKEPDn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2014 10:03:43 -0500
Content-Disposition: inline
In-Reply-To: <1415189302-108476-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: James Bottomley <jbottomley@parallels.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On Wed, Nov 05, 2014 at 01:08:19PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> this patchset updates the ATA stack to correctly detect
> host-managed ZAC devices.

And more importantly exports /dev/sg nodes from them so they can be
actually be accessed.

I'm fine with taking the whole series through the libata tree, so far
there are no conflicting libsas changes on the radar.
