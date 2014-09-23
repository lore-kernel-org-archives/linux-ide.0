From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: change ata_<foo>_printk routines to return void
Date: Tue, 23 Sep 2014 10:03:36 -0400
Message-ID: <20140923140336.GH14905@mtj.dyndns.org>
References: <1411404738.2952.39.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:59754 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbaIWODk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Sep 2014 10:03:40 -0400
Content-Disposition: inline
In-Reply-To: <1411404738.2952.39.camel@joe-AO725>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Sep 22, 2014 at 09:52:18AM -0700, Joe Perches wrote:
> The return value is not used by callers of these functions nor
> by uses of all macros so change the functions to return void.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to libata/for-3.18.

Thanks.

-- 
tejun
