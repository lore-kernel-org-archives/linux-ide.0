From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching
 support
Date: Thu, 03 Sep 2009 15:04:06 +0900
Message-ID: <4A9F5C56.5010605@kernel.org>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <C8E4BD7D001E44499280E0884BD9DB30FC9C7F@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39263 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338AbZICGEK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Sep 2009 02:04:10 -0400
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30FC9C7F@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Shane.

Huang, Shane wrote:
>>>> +		/* time to wait for DEC is not specified by AHCI spec,
>>>> +		 * add a retry loop for safety */
>>>> +		do {
>>>> +			writel(fbs | PORT_FBS_DEC, port_mmio + 
>>> PORT_FBS);
>>>> +			fbs = readl(port_mmio + PORT_FBS);
>>>> +			retries--;
>>>> +		} while ((fbs & PORT_FBS_DEC) && retries);
> 
> 
> At the 2nd thought, if (!pp->fbs_enabled) appears unfortunately
> (although it should not), replacement of if (pp->fbs_enabled) with
> BUG_ON() will lead to the execution of the followed DEC,

Nope, it will result in the executing task being stopped with a scary
stackdump.

> which
> might lead to indeterminate result, because of AHCI v1.2 3.3.16:
> 
> Device Error Clear (DEC): ....... Software shall only set this bit to
> '1' if
> PxFBS.EN is set to '1' and PxFBS.SDE is set to '1'.
> 
> So I would suggest to keep my original implementation in v2, or put
> BUG_ON to the else case, if you insist, to replace the original
> dev_printk(KERN_ERR).

Problem with the original loop is that it writes PORT_FBS_DEC multiple
times.  Assume there are two consecutive device errors, the code might
end up clearing the second one unintentionally.

Thanks.

-- 
tejun
