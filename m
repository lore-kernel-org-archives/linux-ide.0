From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata ATA vs SATA detection and workaround.
Date: Mon, 30 Aug 2004 13:59:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <41336B0E.1090000@pobox.com>
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com> <41321F7F.7050300@pobox.com> <41333CDC.5040106@wasp.net.au> <41334058.4050902@wasp.net.au> <413350A2.1000003@pobox.com> <41335723.40907@wasp.net.au> <413357AE.3000009@pobox.com> <41336141.7010407@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268722AbUH3SEL@vger.kernel.org>
In-Reply-To: <41336141.7010407@wasp.net.au>
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Pretty new at kernel code. (And C for that matter)

Since you've been so helpful, I choose to disbelieve this ;-)


> I did note that it appears it's not going to do the right thing if we 
> have more than one device per host, but I guess thats not going to be an 
> issue for SATA for the near future anyway.
> 
> How's this grab you?

Looks perfect.

Confirm for me that it solves your problem, and I'll push it upstream.

	Jeff
