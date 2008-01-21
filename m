From: Thomas Evans <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Mon, 21 Jan 2008 11:47:07 -0500
Message-ID: <4794CC8B.1010907@gmail.com>
References: <4794459C.3090200@gmail.com> <47944913.6000603@gmail.com> <4794CB8B.1070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:42780 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbYAUQrQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 11:47:16 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1050212wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 08:47:12 -0800 (PST)
In-Reply-To: <4794CB8B.1070600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

I should have mentioned that in 1 of the failing logs, it finds the PMP 
device, that is rare, it usually doesn't even see it.
That happened this morning and I was hopeful that somehow it was more 
meaningful than the usual case where it doesn't even notice the PMP.

...tom

Thomas Evans wrote:
> I've attached a few logs - one that references how things looked when 
> it all worked.
> I've logs of both the original Norco 4618 card (lspci64.2 and 
> dmesg.txt.2) and with the
> newer generic 3124 card (dmesg.txt.newcard lspci.newcard.2).
>
> I'm not so good with deciphering the PCI-isms - maybe I just need a 
> shorter cable now!?
>
> ...tom
>
>

