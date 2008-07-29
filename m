From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix problem with MacBook Pro and 2.6.26
Date: Tue, 29 Jul 2008 11:14:39 +0900
Message-ID: <488E7D0F.4040204@gmail.com>
References: <da38d7b90807240227q165cb5elad937973a58bf88f@mail.gmail.com>	 <488D757B.6000002@gmail.com>	 <da38d7b90807280101y44ef5624of99f7038967405a6@mail.gmail.com> <da38d7b90807281154p6cd45e0pf0acd83cd583d06a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:57535 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbYG2CPG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 22:15:06 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2451059tic.23
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 19:15:05 -0700 (PDT)
In-Reply-To: <da38d7b90807281154p6cd45e0pf0acd83cd583d06a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felipe Sere <dodofxp@gmail.com>
Cc: linux-ide@vger.kernel.org

Felipe Sere wrote:
> 00:1f.2 IDE interface [0101]: Intel Corporation 82801HBM/HEM

> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]

The apple workaround is not kicking in probably because your machine has
different subsystem id which doesn't show in lspci -nn output.  Can you
please post "lspci -nnv" result?

-- 
tejun
