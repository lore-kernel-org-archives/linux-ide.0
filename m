From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.11-rc2 06/09] ide: remove REQ_DRIVE_TASK handling
Date: Sat, 5 Feb 2005 10:43:00 +0000
Message-ID: <20050205104259.GA1184@infradead.org>
References: <42049F20.7020706@home-tj.org> <20050205102843.AA0CA132703@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from pentafluge.infradead.org ([213.146.154.40]:1948 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266516AbVBEKnF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Feb 2005 05:43:05 -0500
Content-Disposition: inline
In-Reply-To: <20050205102843.AA0CA132703@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>  	__REQ_DRIVE_CMD,
> -	__REQ_DRIVE_TASK,
> +	__REQ_DRIVE_TASK,	/* obsolete, unused anymore - tj */

please kill it completely
