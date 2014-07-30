From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] sd: Optionally attach to ZBC devices
Date: Wed, 30 Jul 2014 04:39:05 -0700
Message-ID: <20140730113905.GA12037@infradead.org>
References: <1406645117-53088-1-git-send-email-hare@suse.de>
 <1406645117-53088-5-git-send-email-hare@suse.de>
 <20140729171414.GA1060@infradead.org>
 <53D893B3.6020407@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44011 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbaG3LjH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2014 07:39:07 -0400
Content-Disposition: inline
In-Reply-To: <53D893B3.6020407@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hsh@infradead.org>, James Bottomley <jbottomley@parallels.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Jul 30, 2014 at 08:41:55AM +0200, Hannes Reinecke wrote:
> Yes, eventually. But can't we defer that to a next patchset?
> I'd really like to have this one in, as it makes dealing with ZAC devices
> _so much_ easier ...

I'm happy to put the sd patch in if I can get another review for it.

But even if you want me to carry the libata bits I will need a clear
ACK from Tejun.  And I really think it would belong into the libata
tree.

