From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] sata_via: Enable hotplug on VT6420
Date: Tue, 11 Apr 2017 09:14:22 +0900
Message-ID: <20170411001422.GC29406@wtj.duckdns.org>
References: <1490985342-16800-1-git-send-email-linux@rainbow-software.org>
 <201703312115.34955.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34127 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdDKAOf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Apr 2017 20:14:35 -0400
Content-Disposition: inline
In-Reply-To: <201703312115.34955.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-ide@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Hello,

On Fri, Mar 31, 2017 at 09:15:34PM +0200, Ondrej Zary wrote:
> VT6420 seems to have the same hotplug capability as VT6421.
> 
> However, enabling hotplug needs to expose SCR registers which can cause
> problems. It works for me but might break elsewhere.

Heh, I'm a bit too nervous to apply this patch after all these years.
If somebody really needs it, we can make it conditional on a boot
parameter or sth but I'm not sure about enabling it by default given
the rocky history and age of the device.

Thanks.

-- 
tejun
