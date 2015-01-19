From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: fixup oops in ata_eh_link_report()
Date: Mon, 19 Jan 2015 09:23:45 -0500
Message-ID: <20150119142345.GF8140@htj.dyndns.org>
References: <1421668859-4593-1-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:46101 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbASOXt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2015 09:23:49 -0500
Content-Disposition: inline
In-Reply-To: <1421668859-4593-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On Mon, Jan 19, 2015 at 01:00:59PM +0100, Hannes Reinecke wrote:
> We should only try to evaluate the cdb if this is an ATAPI
> device, for any other device the 'cdb' field and the cdb_len
> has no meaning.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Acked-by: Tejun Heo <tj@kernel.org>

But, can you please refer to the commit which broke it and what the
result of the breakage was?  I suppose this should go through the same
tree that the offending commit went through, right?

Thanks.

-- 
tejun
