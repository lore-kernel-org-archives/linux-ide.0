From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 17:04:21 -0400
Message-ID: <4F8DDAD5.5000405@pobox.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com> <4F8DD834.5070000@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:46568 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab2DQVEY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 17:04:24 -0400
Received: by qafi31 with SMTP id i31so1007985qaf.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2012 14:04:23 -0700 (PDT)
In-Reply-To: <4F8DD834.5070000@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 04/17/2012 04:53 PM, Mark Lord wrote:
> Basically, any unoccupied AHCI port is dead to the world
> after a simple suspend/resume (RAM) cycle.  On one of my machines
> I can hot unplug/replug the ExpressCard adapter to recover,
> but that doesn't work so well for built-in SATA/eSATA ports.

Did you change the patch as requested in the email from 10 min ago?

	Jeff



