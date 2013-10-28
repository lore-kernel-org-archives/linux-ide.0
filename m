From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] drivers/libata: Set max sector to 65535 for Slimtype
 DVD A DS8A9SH drive
Date: Mon, 28 Oct 2013 07:11:08 -0400
Message-ID: <20131028111108.GA11541@mtj.dyndns.org>
References: <1382947681-32619-1-git-send-email-shan.hai@windriver.com>
 <1382947681-32619-2-git-send-email-shan.hai@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:36971 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563Ab3J1LLM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Oct 2013 07:11:12 -0400
Received: by mail-qc0-f181.google.com with SMTP id w4so3696235qcr.12
        for <linux-ide@vger.kernel.org>; Mon, 28 Oct 2013 04:11:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1382947681-32619-2-git-send-email-shan.hai@windriver.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shan Hai <shan.hai@windriver.com>
Cc: linux-ide@vger.kernel.org

On Mon, Oct 28, 2013 at 04:08:01PM +0800, Shan Hai wrote:
> The "Slimtype DVD A  DS8A9SH" drive locks up with following backtrace when
> the max sector is smaller than 65535 bytes, fix it by adding a quirk to set
> the max sector to 65535 bytes.
> 
> INFO: task flush-11:0:663 blocked for more than 120 seconds.
...
>  The above trace was triggered by
>    "dd if=/dev/zero of=/dev/sr0 bs=2048 count=32768"
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Shan Hai <shan.hai@windriver.com>

Applied to libata/for-3.13.  Thanks.

-- 
tejun
