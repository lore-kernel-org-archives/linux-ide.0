From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_sx4: Check return code from pdc20621_i2c_read()
Date: Thu, 6 Aug 2015 12:40:20 -0400
Message-ID: <20150806164020.GT17598@mtj.duckdns.org>
References: <55BFB87C.1010405@cogentembedded.com>
 <1438629493-17610-1-git-send-email-barletz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35259 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbbHFQkX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2015 12:40:23 -0400
Content-Disposition: inline
In-Reply-To: <1438629493-17610-1-git-send-email-barletz@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomer Barletz <barletz@gmail.com>
Cc: sergei.shtylyov@cogentembedded.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 03, 2015 at 12:18:13PM -0700, Tomer Barletz wrote:
> The variable spd0 might be used uninitialized when pdc20621_i2c_read()
> fails.
> This also generates a compilation warning with gcc 5.1.
> 
> Signed-off-by: Tomer Barletz <barletz@gmail.com>

Applied to libata/for-4.2-fixes with minor edits.

Thanks.

-- 
tejun
