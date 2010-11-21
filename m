From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Why so much PIO for r/w accesses ?
Date: Sun, 21 Nov 2010 18:39:51 -0500
Message-ID: <4CE9ADC7.8040800@teksavvy.com>
References: <4CE9ACAA.9060203@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:4456 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754768Ab0KUXjx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Nov 2010 18:39:53 -0500
In-Reply-To: <4CE9ACAA.9060203@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

On 10-11-21 06:35 PM, Mark Lord wrote:
> While working on something unrelated today,
> I instrumented ata_sff_data_xfer32() to generate a printk() on each invocation.
>
> Imagine then my complete surprise to see that print() being invoked very frequently
> after rebooting with the modified kernel.
>
> ata_sff_data_xfer32() is for PIO read/writes.. something that I don't expect to
> see.
>
> This is an ata_piix system, with a pure SATA SSD.
> Why are we using PIO so much?
> Or am I simply misunderstanding something basic here.. ?
>
> Confused.

Definitely just me being confused.  :)

I changed the printk() into an ata_dev_printk(), and discovered that
all of those reads/writes are targeting the DVD-RW drive, not the SSD.

So this is simply hald or something similar polling for disc-insertion,
and PIO is used (as always) for the PACKET command transfer.

Duh.  :)
