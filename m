From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/5] storage-fixup: add ASUS F6S with seagate devices
Date: Wed, 12 Nov 2008 14:26:14 +0900
Message-ID: <491A68F6.7060107@kernel.org>
References: <200810290908.54442.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53069 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbYKLF0c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 00:26:32 -0500
In-Reply-To: <200810290908.54442.kel@otaku42.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kel Modderman <kel@otaku42.de>
Cc: linux-ide@vger.kernel.org

Kel Modderman wrote:
> The ASUS F6S was generating approx. 3 clicks per minute without the APM
> workaround, with two different seagate drives of similar model but differing
> cache/capacity.
> 
> Any value ~ 192 or above is enough to have the clicking cease, is the lowest
> possible number preferable?
> 
> Signed-off-by: Kel Modderman <kel@otaku42.de>

applied.

-- 
tejun
