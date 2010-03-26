From: Tejun Heo <tj@kernel.org>
Subject: Re: PMP failure decoding help
Date: Fri, 26 Mar 2010 15:06:31 +0900
Message-ID: <4BAC4EE7.4000207@kernel.org>
References: <20100325182109.GZ4442@merlins.org> <4BAC14F9.4070109@gmail.com> <20100326030846.GI4442@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54821 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128Ab0CZGKO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Mar 2010 02:10:14 -0400
In-Reply-To: <20100326030846.GI4442@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Hello,

On 03/26/2010 12:08 PM, Marc MERLIN wrote:
> Wep. I snipped it not to muddle the logs.
> scsi_eh_7: page allocation failure. order:4, mode:0x10
> Pid: 1798, comm: scsi_eh_7 Not tainted 2.6.31.6-core2smp-1khznohz-preempt-noticks-noide-4gb-20091118 #1
> Call Trace:
>  [<c03a2203>] ? printk+0xf/0x14
>  [<c017735b>] __alloc_pages_nodemask+0x3da/0x41c
>  [<c01907ff>] cache_alloc_refill+0x245/0x404
>  [<c0190b23>] kmem_cache_alloc+0x4f/0xe4
>  [<c02f035c>] sata_pmp_attach+0xde/0x355
>  [<c02ebcfa>] ata_eh_recover+0x5d6/0xa8b

Ugh... that's probably

	pmp_link = kzalloc(sizeof(pmp_link[0]) * SATA_PMP_MAX_PORTS, GFP_NOIO);

in sata_pmp_init_links().  We probably should either put that in
vmalloc space or make it an indirect array.

-- 
tejun
