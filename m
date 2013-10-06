From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: kernel 3.6+  problem with Marvell 88SE9172 SATA Controller
Date: Sat, 05 Oct 2013 19:00:30 -0600
Message-ID: <5250B62E.4080407@gmail.com>
References: <524E4C29.10506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:45738 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab3JFBAe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Oct 2013 21:00:34 -0400
Received: by mail-ie0-f172.google.com with SMTP id x13so12832356ief.17
        for <linux-ide@vger.kernel.org>; Sat, 05 Oct 2013 18:00:34 -0700 (PDT)
In-Reply-To: <524E4C29.10506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Davidovac Zoran <davidovacz@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 10/03/2013 11:03 PM, Davidovac Zoran wrote:
> Dear All,
>
> After I've upgraded from kernel 3.4.X to 3.10.14 and I noticed 2 drives
> missing that
> are connected on Marvell 88SE9172 SATA Controller.
>
> The last version that worked properly was 3.5.7, but any kernel above
> 3.6.0+ drives connected to Marvell are missing.
>
> This was tested on Board GA-X79-UD5
> http://www.gigabyte.com/products/product-page.aspx?pid=4049#sp
> that have 3 x Marvell 88SE9172 chips.
>
> tested kernels:
> linux-3.10.1.tar.xz   linux-3.12-rc3.tar.xz  linux-3.6.11.tar.xz
> linux-3.7.10.tar.xz
> linux-3.10.14.tar.xz  linux-3.4.64.tar.xz    linux-3.6.5.tar.xz
> linux-3.8.13.tar.xz
> linux-3.11.3.tar.xz   linux-3.5.7.tar.xz     linux-3.6.tar.xz
> linux-3.9.11.tar.xz
>
> 3.6.0+ dmesg:
> ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> dmar: DRHD: handling fault status reg 502
> dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
> DMAR:[fault reason 02] Present bit in context entry is clear

This is likely a known problem with some Marvell SATA controllers in 
combination with the Intel IOMMU being enabled. The controller is 
issuing DMA requests from the wrong device address which get blocked by 
the IOMMU because that device isn't supposed to be accessing the memory. 
I thought there was some efforts to add a workaround for this, but 
haven't heard anything about it recently.

