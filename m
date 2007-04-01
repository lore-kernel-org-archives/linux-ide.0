From: Tejun Heo <htejun@gmail.com>
Subject: Re: [-mm patch] make drivers/ata/pata_ali.c:ali_tf_load() static
Date: Mon, 02 Apr 2007 01:21:12 +0900
Message-ID: <460FDBF8.4040002@gmail.com>
References: <20070330010559.2a232d9a.akpm@linux-foundation.org> <20070331204856.GY14134@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:61523 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933591AbXDAQVT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Apr 2007 12:21:19 -0400
Received: by an-out-0708.google.com with SMTP id b33so992900ana
        for <linux-ide@vger.kernel.org>; Sun, 01 Apr 2007 09:21:18 -0700 (PDT)
In-Reply-To: <20070331204856.GY14134@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Adrian Bunk wrote:
> On Fri, Mar 30, 2007 at 01:05:59AM -0700, Andrew Morton wrote:
>> ...
>> Changes since 2.6.21-rc5-mm2:
>> ...
>> +testing-patch-for-ali-pata-fixes-hopefully-for-the-problems-with-atapi-dma.patch
>>
>>  pata experiment
>> ...
> 
> 
> This patch makes the needlesly global ali_tf_load() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
