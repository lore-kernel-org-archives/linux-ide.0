From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: hpt366: fix incorrect mask when checking at
 cmd_high_time
Date: Tue, 26 Jul 2016 15:26:17 -0700 (PDT)
Message-ID: <20160726.152617.309548003660454771.davem@davemloft.net>
References: <1468321179-7647-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:42056 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758677AbcGZW0S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2016 18:26:18 -0400
In-Reply-To: <1468321179-7647-1-git-send-email-colin.king@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: colin.king@canonical.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 12 Jul 2016 11:59:39 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> According to the HPT366 data sheet, PCI config space dword 0x40-0x43
> bits 11:8 specify the primary drive cmd_high_time, however,
> currently just 3 bits of the 4 are being used because the mask
> is 0x07 and not 0x0f.  Fix the mask, allowing for the 40MHz clock
> to be detected.
> 
> Also add in missing space between switch and parenthesis to clean
> up a checkpatch warning.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
