From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Read Prefetch, Post Write on IDE chipsets
Date: Sun, 02 Sep 2007 15:04:22 +0100
Message-ID: <46DAC2E6.6070102@genesi-usa.com>
References: <46DAB1DF.5050109@genesi-usa.com> <20070902150034.7a6713f5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:3697 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344AbXIBOCu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 10:02:50 -0400
In-Reply-To: <20070902150034.7a6713f5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Sun, 02 Sep 2007 13:51:43 +0100
> Matt Sealey <matt@genesi-usa.com> wrote:
> 
>> But, what is it? I've never seen any documentation but which register to use
>> to toggle it.. no vendor recommendations to turn it on, it seems like a rather
>> secret feature..?
> 
> Chipset specific. Some public documentation discusses it for certain
> chips (eg the Intel ATA tuning guidelines). For others you may need the
> BIOS vendor manual or similar.

All I see is.. that if you want to turn it on, you must make sure of a few things.

There is no discussion on what it DOES, I assume it simply buffers a little more
somewhere (somehow?) inside the chipset, for the purpose of allowing more
streamlined PIO access. But it has some awesome limitations..

Is it even relevant anymore? Does anyone even notice if these features are turned off?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
