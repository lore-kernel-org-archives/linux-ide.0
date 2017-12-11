From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5] pata_pdc2027x: Fix pdc_adjust_pll() to return the
 error value
Date: Mon, 11 Dec 2017 07:10:22 -0800
Message-ID: <20171211151022.GD2421075@devbig577.frc2.facebook.com>
References: <8a90e02cc2ccca6277702b6b7ec8f5ca1f85ba4d.1512580696.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:46419 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdLKPK0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2017 10:10:26 -0500
Content-Disposition: inline
In-Reply-To: <8a90e02cc2ccca6277702b6b7ec8f5ca1f85ba4d.1512580696.git.arvind.yadav.cs@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Dec 06, 2017 at 10:52:54PM +0530, Arvind Yadav wrote:
> This change is to ensure that function pdc_adjust_pll() returns the
> error value to avoid the unnecessary error check for pdc_hardware_init()
> in pdc2027x_reinit_one().
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Doesn't apply on libata/for-4.16.

Thanks.

-- 
tejun
