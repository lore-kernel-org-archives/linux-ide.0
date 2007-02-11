From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata updates 1 of 3
Date: Sun, 11 Feb 2007 17:08:17 -0500
Message-ID: <45CF93D1.9080009@gmail.com>
References: <20070210010914.GA19717@havoc.gtf.org> <20070210054629.GA4395@gentoox2.trippelsdorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:4774 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932571AbXBKWIj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Feb 2007 17:08:39 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1603372wxd
        for <linux-ide@vger.kernel.org>; Sun, 11 Feb 2007 14:08:38 -0800 (PST)
In-Reply-To: <20070210054629.GA4395@gentoox2.trippelsdorf.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Markus Trippelsdorf wrote:
> This update breaks sata_via on my VIA K8T800Pro machine:
>  
>  sata_via 0000:00:0f.0 : failed to iomap PCI BAR 0
>  sata_via 0000:00:0f.0 : out of memory
>  sata_via probe of 0000:00:0f.0 failed with error -12

Please post full dmesg and the result of 'lspci -nnvvvxxx'.

-- 
tejun
