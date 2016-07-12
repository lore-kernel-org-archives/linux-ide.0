From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: hpt366: fix incorrect mask when checking at
 cmd_high_time
Date: Tue, 12 Jul 2016 11:03:22 -0400
Message-ID: <20160712150322.GI3190@htj.duckdns.org>
References: <1468322179-9398-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36792 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbcGLPDa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 11:03:30 -0400
Content-Disposition: inline
In-Reply-To: <1468322179-9398-1-git-send-email-colin.king@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: kernel-tram@lists.ubuntu.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 12, 2016 at 12:16:19PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> According to the HPT366 data sheet, PCI config space dword 0x40-0x43
> bits 11:8 specify the primary drive cmd_high_time, however,
> currently just 3 bits of the 4 are being used because the mask
> is 0x700 and not 0x0f00.  Fix the mask, allowing for the 40MHz clock
> to be detected.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to libata/for-4.8.

Thanks.

-- 
tejun
