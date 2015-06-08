From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_octeon_cf: fix broken build
Date: Mon, 8 Jun 2015 18:12:07 +0900
Message-ID: <20150608091207.GG21465@mtj.duckdns.org>
References: <1433752363-6373-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33121 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbbFHJMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jun 2015 05:12:15 -0400
Content-Disposition: inline
In-Reply-To: <1433752363-6373-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

Hello,

On Mon, Jun 08, 2015 at 11:32:43AM +0300, Aaro Koskinen wrote:
> MODULE_DEVICE_TABLE is referring to wrong driver's table and breaks the
> build. Fix that.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Applied to libata/for-4.1-fixes.

Thanks.

-- 
tejun
