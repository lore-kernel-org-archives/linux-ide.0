From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/4] libata: Expose TRIM capability in sysfs
Date: Tue, 5 May 2015 10:50:55 -0700
Message-ID: <20150505175055.GA24551@infradead.org>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
 <1430790861-30066-2-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60399 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030279AbbEERu5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2015 13:50:57 -0400
Content-Disposition: inline
In-Reply-To: <1430790861-30066-2-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: tj@kernel.org, hare@suse.de, linux-ide@vger.kernel.org

> +	forced_unqueued:	Drive's unqueued DSM support is known to be
> +				buggy and only unqueued TRIM commands
> +				are sent

Shouldn't the first "unqueued" be a "queued"

