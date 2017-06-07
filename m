From: Christoph Hellwig <hch@infradead.org>
Subject: Re: ZBC_IN command translation
Date: Wed, 7 Jun 2017 06:24:43 -0700
Message-ID: <20170607132443.GA3501@infradead.org>
References: <4b12630e-1add-6a4e-51ab-52417e60d4b2@wdc.com>
 <20170607090751.GA29487@infradead.org>
 <f9d14e79-fffd-1398-4767-ffe527bf9ee6@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdFGNYo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jun 2017 09:24:44 -0400
Content-Disposition: inline
In-Reply-To: <f9d14e79-fffd-1398-4767-ffe527bf9ee6@wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>

On Wed, Jun 07, 2017 at 06:11:33PM +0900, Damien Le Moal wrote:
> Sure, that is one solution. However, not a ideal one as that would
> prevent ZBC/ZAC drives working with target/iscsi.
> There are a few problems there that I am fixing right now, but that
> translation error is stopping all effort.

The normal way to use the target code is through the block layer.
