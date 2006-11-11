From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2 #upstream] ahci: honor PORTS_IMPL on ICH8s
Date: Sat, 11 Nov 2006 11:37:37 +0900
Message-ID: <45553771.4030201@gmail.com>
References: <20061102031723.GV13677@htj.dyndns.org> <20061102032059.GW13677@htj.dyndns.org> <20061106010505.GJ15897@curie-int.orbis-terrarum.net> <20061109060840.GZ13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:7129 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946950AbWKKChr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 21:37:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1522444nfa
        for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2006 18:37:45 -0800 (PST)
In-Reply-To: <20061109060840.GZ13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Robin H. Johnson" <robbat2@gentoo.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Some ICH8s use non-linear port mapping.  ahci driver didn't use to
> honor PORTS_IMPL and this made ports after hole nonfunctional.  This
> patch makes ahci mark those ports as dummy and properly initialize all
> the implemented ports after the dummies.
> 
> As it's unknown whether other AHCIs implement PORTS_IMPL register
> properly, new board id board_ahci_pi is added and selectively applied
> to ICH8s.  All other AHCIs continue to use linear mapping regardless
> of PORTS_IMPL value.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Robin H. Johnson <robbat2@gentoo.org>
> ---
> 
> Two changes.
> 
> * AHCI_FLAG_HONOR_PI was changed to 1<<25.  1<<23 is not for LLD
>   specific flags.
> 
> * VPRINTK() fixed as Robin H. Johnson pointed out.

Jeff, I think this should go into #upstream-fixes too.  It's not as dumb 
as adding a PCI ID but it's adding support for a highly popular hardware 
and "wait for 2.6.20 for ICH8 support" just sucks.

Thanks.

-- 
tejun
