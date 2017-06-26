From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_via: Enable optional hotplug on VT6420
Date: Mon, 26 Jun 2017 16:56:01 -0400
Message-ID: <20170626205601.GD27428@htj.duckdns.org>
References: <20170625202536.14925-1-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f173.google.com ([209.85.213.173]:35490 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFZU4E (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jun 2017 16:56:04 -0400
Content-Disposition: inline
In-Reply-To: <20170625202536.14925-1-linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-ide@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Sun, Jun 25, 2017 at 10:25:36PM +0200, Ondrej Zary wrote:
> VT6420 seems to have the same hotplug capability as VT6421.
> 
> However, enabling hotplug needs to expose SCR registers which can cause
> problems. It works for me but might break elsewhere. So add a module
> parameter vt6420_hotplug to enable this feature.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Applied to libata/for-4.13.

Thanks.

-- 
tejun
