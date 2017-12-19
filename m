From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: apply MAX_SEC_1024 to all LITEON EP1 series
 devices
Date: Tue, 19 Dec 2017 05:30:26 -0800
Message-ID: <20171219133026.GK3919388@devbig577.frc2.facebook.com>
References: <20171217121339.7772-1-xinyu0123@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33537 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759619AbdLSNaf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2017 08:30:35 -0500
Received: by mail-qt0-f171.google.com with SMTP id e2so24160370qti.0
        for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2017 05:30:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171217121339.7772-1-xinyu0123@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xinyu Lin <xinyu0123@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Dec 17, 2017 at 08:13:39PM +0800, Xinyu Lin wrote:
> LITEON EP1 has the same timeout issues as CX1 series devices.
> 
> Revert max_sectors to the value of 1024.
> 
> 'e0edc8c54646 ("libata: apply MAX_SEC_1024 to all CX1-JB*-HP devices")'
> 
> Signed-off-by: Xinyu Lin <xinyu0123@gmail.com>

Applied to libata/for-4.15-fixes.

Thanks.

-- 
tejun
