From: Tejun Heo <htejun@gmail.com>
Subject: Re: Linux, SATA and Port Multiplier
Date: Tue, 23 Oct 2007 17:13:36 +0900
Message-ID: <471DAD30.8090205@gmail.com>
References: <470B3394.5040305@jordet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:15009 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbXJWINs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 04:13:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1420271rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 01:13:46 -0700 (PDT)
In-Reply-To: <470B3394.5040305@jordet.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stian Jordet <liste@jordet.net>
Cc: linux-ide@vger.kernel.org

Stian Jordet wrote:
> Hello,
> 
> I'm just trying to be a little proactive. I need to buy a sata card to
> use with an older Intel SC450NX server. I want to use this cabinet:
> 
> http://www.stardom.com.tw/sohotank%20st6600.htm
> 
> Thus I need port multiplier support. I would also like to have a card
> with both eSATA og interne SATA connectors. I have looked around, and
> found this:
> 
> http://www.highpoint-tech.com/USA/rr1742.htm
> 
> It seems to use the Marvell 88SX6042 chipset. Does this support port
> multiplier? If not, do you have any recommendations for any PCI
> sata-controller that supports port multiplier? It doesn't have to have
> eSATA, but it needs to have internal sata, and eSATA is a plus.

Currently supported controllers are sil3124/32 family and ahci
controllers w/ PMP support (ICH9, JMBs).

-- 
tejun
