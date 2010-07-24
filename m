From: Yuhong Bao <yuhongbao_386@hotmail.com>
Subject: RE: support for drives larger than 2TiB
Date: Sat, 24 Jul 2010 11:40:02 -0700
Message-ID: <SNT125-W4469FAC3FE110BB4882949C3A40@phx.gbl>
References: <4C4AB952.9030705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from snt0-omc3-s1.snt0.hotmail.com ([65.55.90.140]:29058 "EHLO
	snt0-omc3-s1.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754368Ab0GXSqO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jul 2010 14:46:14 -0400
In-Reply-To: <4C4AB952.9030705@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, jeff@garzik.org, ben.collins@ubuntu.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, hmh@debian.org


> However, 2TiB limit is
> inherent in the BIOS programming interface and currently the only way
> to overcome it is using a completely different BIOS interface (EFI,
> that is).
Nope, look at the Int13 extensions, it already support 64-bit LBA.

Yuhong Bao
 		 	   		  
_________________________________________________________________
The New Busy is not the too busy. Combine all your e-mail accounts with Hotmail.
http://www.windowslive.com/campaign/thenewbusy?tile=multiaccount&ocid=PID28326::T:WLMTAGL:ON:WL:en-US:WM_HMP:042010_4