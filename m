From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Tue, 7 Aug 2007 17:57:59 +0100
Message-ID: <20070807175759.149bdf9f@the-village.bc.nu>
References: <20070807054250.GQ13674@htj.dyndns.org>
	<20070807162529.1781b21c@the-village.bc.nu>
	<46B89177.2040209@gmail.com>
	<46B8941A.8080206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35585 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751598AbXHGQvW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 12:51:22 -0400
In-Reply-To: <46B8941A.8080206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kelk1@comcast.net, lcapitulino@mandriva.com.br, Ben Collins <bcollins@ubuntu.com>

On Tue, 07 Aug 2007 11:47:38 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> People should check out Ben C's HPA fixes and cleanups, too. (attached)
> 
> I was hoping one of the original libata HPA authors would review that in 
> depth and integrate.  (it no longer applies cleanly)

Looks basically sound but we should still probably move over this bit of
the old IDE paranoia as well:

/*
 * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
 * so on non-buggy drives we need test only one.
 * However, we should also check whether these fields are valid.  
 */
static inline int idedisk_supports_hpa(const struct hd_driveid *id)
{
        return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 &0x0400); }


---

