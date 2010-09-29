From: Richard <tuxbox.guru@gmail.com>
Subject: Re: Marvel PMP SATA controller
Date: Wed, 29 Sep 2010 21:32:59 +0100
Message-ID: <4CA3A27B.3030906@gmail.com>
References: <4CA2E33B.70001@gmail.com> <4CA399FD.6030904@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34760 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab0I2UdD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2010 16:33:03 -0400
Received: by wyb28 with SMTP id 28so1162909wyb.19
        for <linux-ide@vger.kernel.org>; Wed, 29 Sep 2010 13:33:02 -0700 (PDT)
In-Reply-To: <4CA399FD.6030904@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: linux-ide@vger.kernel.org

On 29/09/10 20:56, Mark Lord wrote:
> On 10-09-29 02:56 AM, Richard wrote:
>> Morning all,
>>
>> Using the Marvel Port Multiplier I am stuck trying to get it working 
>> with some Hard drives.
>
>
> Err.. just plug some drives into it, and then plug it (the PMP) into
> a SATA controller that supports PMP (eg. the Marvell ones, newer AHCI, 
> some Sil ones, etc..).
>
> What are you trying to do?
Hi Mark,

Its an embedded device whereby the one HDD I have does not work with the 
Marvel PMP. I have the command to send to the PMP controller but I am 
not an officianado with linux SATA(the code I have is from VxWorks) The 
drive is confirmed working, but the PMP chip does not default to SATA 
Generation 1, and this HDD is a bit dumb to figure it out :) - so I have 
to force the PMP controller to Gen1 mode.
(I have tons of drives that work just fine, its just this ONE Maxtor 
drive that is being a pain)

The short - I need to write a command to the SATA controller before this 
HDD can be recognised.

Much appreciated,
Richard

