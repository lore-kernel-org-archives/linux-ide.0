From: Tejun Heo <htejun@gmail.com>
Subject: Re: PROBLEM: SATA AHCI driver significant throughput loss in 2.6.22-rc5-g75154f40-dirty
Date: Tue, 03 Jul 2007 17:24:00 +0900
Message-ID: <468A07A0.5010302@gmail.com>
References: <439fa30706262117u2d5553dfp8395c6ca41574a8c@mail.gmail.com> <6bffcb0e0706290636t334e2e29h17d215cee77dc2da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:61570 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbXGCIZU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 04:25:20 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1147515nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 01:25:19 -0700 (PDT)
In-Reply-To: <6bffcb0e0706290636t334e2e29h17d215cee77dc2da@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Dan <metalifloyd@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Michal Piotrowski wrote:
> Hi,
> 
> [adding linux-ide to cc]
> 
> On 27/06/07, Dan <metalifloyd@gmail.com> wrote:
>> Something changed with the AHCI SATA driver in the latest git version.
>> With 2.6.21 I get ~49MB/sec according to hdparm. Using the latest git
>> version I only get ~8MB/sec. I've attached my .config and have
>> included some info about my system below. Please let me know if you
>> need more information or if I can help test anything.

Please post boot dmesgs of before and after.

-- 
tejun
