From: Brad Campbell <brad@wasp.net.au>
Subject: Re: [sata] status report, libata-dev queue updated
Date: Fri, 01 Oct 2004 15:55:52 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415D45C8.3070207@wasp.net.au>
References: <20041001045822.GA25784@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:27571 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S269774AbUJALz0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Oct 2004 07:55:26 -0400
In-Reply-To: <20041001045822.GA25784@havoc.gtf.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Jeff Garzik wrote:
> Notable updates:
> * new driver for ULi SATA (formerly ALi)
> * SMART support via ATA passthru CDB
> * support for Promise PATA ports
> 

<snip>
> 
> Patch:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-rc3-libata-dev1.patch.bz2
> 

I'd just like to give this the "two thumbs up". I'm getting great results from the SMART support 
(Thanks Andy and John!)

Brad
