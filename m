From: Tejun Heo <tj@kernel.org>
Subject: Re: PMP and Smart Enclosure ...
Date: Tue, 29 Mar 2011 17:01:04 +0200
Message-ID: <20110329150104.GD29865@htj.dyndns.org>
References: <20110322145440.GA15541@MAIL.13thfloor.at>
 <20110322152529.GB15541@MAIL.13thfloor.at>
 <20110328085211.GD16530@htj.dyndns.org>
 <20110328123623.GD25384@MAIL.13thfloor.at>
 <20110328160136.GC6736@htj.dyndns.org>
 <20110328224642.GJ25384@MAIL.13thfloor.at>
 <20110328234729.GK25384@MAIL.13thfloor.at>
 <20110329080321.GG6736@htj.dyndns.org>
 <20110329144906.GN25384@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53974 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab1C2PBJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Mar 2011 11:01:09 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so278043fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Mar 2011 08:01:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110329144906.GN25384@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-ide@vger.kernel.org

On Tue, Mar 29, 2011 at 04:49:06PM +0200, Herbert Poetzl wrote:
> PS: any thoughts on how/where I should add the device 
>     interface for the SATA PMP?

One way would be adding a device node for the PMP device but I don't
have much idea how it should look like.  The thing is that PMP isn't a
completely separate device.  It's more of a dummy hub and an extension
of the host SATA bus rather than a separate device.  Maybe it's best
to just put it together on the host itself.

-- 
tejun
