From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG REPORT, 2.6.22] sata controler failure on nforce 2 chipset
Date: Fri, 25 Apr 2008 23:11:08 -0700
Message-ID: <20080425231108.03dfa7cb.akpm@linux-foundation.org>
References: <396712385.20080423011459@3d-io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38189 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751836AbYDZGMB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Apr 2008 02:12:01 -0400
In-Reply-To: <396712385.20080423011459@3d-io.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: speedy <speedy@3d-io.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> On Wed, 23 Apr 2008 01:14:59 +0200 speedy <speedy@3d-io.com> wrote:
> Hello Linux kernel crew,
> 
>        [Consider this more as a datapoint then a bug report, as after
>        one network and one sata/southbridge issues showing up
>        interminnently, the ASRock motherboard involved will be
>        scrapped for a different one]
> 
>        The integrated NVidia sata controller and/or the hard-drive has failed
>        during operation with the following output:

2.6.22 is rather old.  Can you please retest 2.6.25?

Thanks.
