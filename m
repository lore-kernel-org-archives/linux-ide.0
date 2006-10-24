From: Daniel Drake <dsd@gentoo.org>
Subject: Re: sata_via issue for VIA Epia SP8000 in 2.6.18[.1]?
Date: Mon, 23 Oct 2006 20:04:00 -0400
Message-ID: <453D5870.20308@gentoo.org>
References: <453B61D9.9060707@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:21984 "EHLO
	smtp121.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S932349AbWJXAFA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Oct 2006 20:05:00 -0400
In-Reply-To: <453B61D9.9060707@xs4all.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Udo van den Heuvel wrote:
> Hello,
> 
> 2.6.17.13 works OK on this VIA Epia SP8000.
> (remember vaguely about some (PCI?) fixups to get things going)
> Now I try to get 2.6.18.1 working. SATA is detected by this kernel but
> disk gives timeout while 2.6.17.13 boots fine.
> 
> Some burbs:
> 
> Links is up but  SStatus 113 SControl 300
> qc timeout (cmd 0xec)
> failed to IDENTIFY
> This results in a kernel panic.

Try this patch:
http://marc.theaimsgroup.com/?l=git-commits-head&m=116121959622812&q=raw

If that doesn't help, I guess you're seeing the same as 
https://bugs.gentoo.org/150773

Daniel


