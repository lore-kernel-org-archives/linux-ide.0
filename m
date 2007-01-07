From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.20-rc2-mm1] slc90e66: carry over fixes from piix driver
Date: Sun, 7 Jan 2007 02:27:59 +0100
Message-ID: <58cb370e0701061727h63558fb5ye298a51feb7606df@mail.gmail.com>
References: <200612302132.15641.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:46703 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbXAGB2B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Jan 2007 20:28:01 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8952044nfa
        for <linux-ide@vger.kernel.org>; Sat, 06 Jan 2007 17:27:59 -0800 (PST)
In-Reply-To: <200612302132.15641.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 12/30/06, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Synchronize with version 0.46 of the Intel PIIX/ICH driver:
>
> - carry over Alan's and my own fixes in the tuneproc() method and my cleanups
>   both there and in the ratemask() method;
>
> - SLC90E66 only supports MW DMA modes 1/2 and SW DMA mode 2 (just like Intel
>   chips), so don't claim support for other MW/SW DMA modes;
>
> - don't check dor non-NULL drive->id in the ide_dma_check() method -- this is
>   assumed to be true in all other drivers;
>
> - do some coding/formatting cleanups while at it...
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
