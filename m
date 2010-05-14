From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] PXA DMA-capable PATA driver
Date: Fri, 14 May 2010 13:42:14 -0400
Message-ID: <4BED8B76.5010701@garzik.org>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com> <201005141551.55066.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:45876 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758138Ab0ENRmR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 13:42:17 -0400
Received: by ywh36 with SMTP id 36so1338464ywh.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 10:42:16 -0700 (PDT)
In-Reply-To: <201005141551.55066.marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, radoslav.deak@voipac.com

On 05/14/2010 09:51 AM, Marek Vasut wrote:
> Dne Po 10. kv=C4=9Btna 2010 05:02:05 Marek Vasut napsal(a):
>> This patch adds a driver for a harddrive attached to PXA address and=
 data
>> bus. Unlike pata_platform, this driver allows usage of PXA DMA contr=
oller,
>> making the transmission speed 3x higher.
>>
>> Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
>
> Hey, any updates on this ?

It's queued for #upstream review, should get merged today or tomorrow.

Typically I wait a while, for comments from PATA-interested folks.

	Jeff




