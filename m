From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata AHCI support for Intel ICH6RW
Date: Fri, 03 Sep 2004 07:48:40 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41385A18.5020103@pobox.com>
References: <1094184596.16175.3.camel@unicorn.rpratap.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13452 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269636AbUICLtA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Sep 2004 07:49:00 -0400
In-Reply-To: <1094184596.16175.3.camel@unicorn.rpratap.homelinux.org>
List-Id: linux-ide@vger.kernel.org
To: Ravi Pratap M <ravi@ximian.com>
Cc: linux-ide@vger.kernel.org, russb@emc.com

Ravi Pratap M wrote:
> Hi guys,
> 
> My Dell Dimension 8400 machine has the latest Intel ICH6RW controller
> and I am running kernel 2.6.8.1. I was under the impression that
> libata's ata_piix driver now supports AHCI mode but when I set the BIOS
> to that setting, the kernel doesn't see anything.
> 
> 
> Has the AHCI driver not fully been integrated into mainline libata ? I
> downloaded the latest prepatch kernel but I still don't see any AHCI
> driver (I found an ahci.c that you posted to linux-kernel sometime in
> April 2004 but that is missing from the main linux kernel source tree
> that I have downloaded here).


Nothing new to add beyond that of
http://linux.yyz.us/sata/sata-status.html

AHCI _should_ be going in any day now (well, after Labor Day vacation), 
so it will appear RSN.

	Jeff


