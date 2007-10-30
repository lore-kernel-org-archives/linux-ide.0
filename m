From: Harald Dunkel <harald.dunkel@t-online.de>
Subject: Re: 2.6.24-rc1, sata_sil: access to SH-S183A broken again?
Date: Tue, 30 Oct 2007 08:52:14 +0100
Message-ID: <4726E2AE.2080009@t-online.de>
References: <4724845D.4020903@t-online.de> <47254B67.2050301@gmail.com> <4725A652.3090902@t-online.de> <4725AAC6.5070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout01.sul.t-online.de ([194.25.134.80]:58875 "EHLO
	mailout01.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751415AbXJ3HwT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 03:52:19 -0400
In-Reply-To: <4725AAC6.5070702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi Tejun,

Tejun Heo wrote:
> 
> Were you able to reproduce it?  If it actually is the same problem
> (ATAPI DMA timing out on data transfers of certain size), it should be
> reproducible when you repeat the same thing.
> 

I tried several times this morning, but I couldn't reproduce it.
Maybe its really the hardware. I would suggest to put it on hold.


Thanx anyway

Harri

