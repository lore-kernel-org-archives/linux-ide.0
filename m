From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: remove superfluous casts
Date: Wed, 26 Mar 2014 12:38:14 -0400
Message-ID: <20140326163814.GI7171@htj.dyndns.org>
References: <11638294.fp3ZK6zVlg@amdc1032>
 <20140326154230.GG7171@htj.dyndns.org>
 <1395851689.3726.23.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:47510 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbaCZQiR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2014 12:38:17 -0400
Content-Disposition: inline
In-Reply-To: <1395851689.3726.23.camel@joe-AO722>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, Mar 26, 2014 at 09:34:49AM -0700, Joe Perches wrote:
> Unreferenced casts of void * types are unnecessary so remove them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
