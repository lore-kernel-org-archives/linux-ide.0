From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCHSET] libata: improve ata_bus_probe failure handling, take
 2
Date: Mon, 03 Apr 2006 17:37:51 +0800
Message-ID: <4430ECEF.30307@tw.ibm.com>
References: <11439680863256-git-send-email-htejun@gmail.com> <442FE142.7030304@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:19845 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751702AbWDCJiM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Apr 2006 05:38:12 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k339c43D006690
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 05:38:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k339fEnD045586
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 03:41:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k339c3eA000786
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 03:38:03 -0600
In-Reply-To: <442FE142.7030304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Applied both series to #upstream.
> 
> Albert, please check the irq-pio branch and make sure my merge is correct.
> 

The irq-pio branch looks good.

I've a minor fix for cleanup, etc.
Will submit it later.

Albert




