From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/4] libata-scsi: Update SATL for ZAC drives
Date: Tue, 29 Jul 2014 10:12:58 -0700
Message-ID: <20140729171258.GB32713@infradead.org>
References: <1406645117-53088-1-git-send-email-hare@suse.de>
 <1406645117-53088-4-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34962 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbaG2RNB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2014 13:13:01 -0400
Content-Disposition: inline
In-Reply-To: <1406645117-53088-4-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hsh@infradead.org>, James Bottomley <jbottomley@parallels.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On Tue, Jul 29, 2014 at 04:45:16PM +0200, Hannes Reinecke wrote:
> ZAC (zoned-access command) drives translate into ZBC (Zoned block
> command) device type for SCSI. So implement the correct mappings
> into libata-scsi and update the SCSI command set versions.

This seems to both set the periphal type to ZBC and set the
HAW_ZBC bit, which is invalid for the version of ZBC spec I've seen.

Doesn't ZAC also destinguish between host aware and host managed device
like ZBC does?

