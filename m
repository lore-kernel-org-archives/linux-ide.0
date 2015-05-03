From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: samsung_cf: Constify platform_device_id
Date: Sat, 2 May 2015 22:06:19 -0400
Message-ID: <20150503020619.GI1949@htj.duckdns.org>
References: <1430495956-32215-1-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35070 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbECCGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 May 2015 22:06:22 -0400
Content-Disposition: inline
In-Reply-To: <1430495956-32215-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 02, 2015 at 12:59:16AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Applied to libata/for-4.2.

Thanks.

-- 
tejun
