From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fallback to the other IDENTIFY on device error,
 take#2
Date: Sun, 13 May 2007 14:57:44 +0200
Message-ID: <46470B48.7050101@gmail.com>
References: <20070427175205.GD7809@electro-mechanical.com> <4635C35D.1020807@gmail.com> <20070430202107.GF5942@electro-mechanical.com> <4636C2C7.8090206@gmail.com> <20070501121703.GH5942@electro-mechanical.com> <46373AEE.6070908@rtr.ca> <20070501131818.GA18521@electro-mechanical.com> <46374354.7040307@gmail.com> <20070501172117.GA20328@electro-mechanical.com> <463F56F2.3010106@gmail.com> <4642627A.4030606@garzik.org> <46446311.3000208@gmail.com> <4644E9E5.3000402@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:54675 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932785AbXEMM7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 May 2007 08:59:02 -0400
Received: by py-out-1112.google.com with SMTP id a29so1246319pyi
        for <linux-ide@vger.kernel.org>; Sun, 13 May 2007 05:59:01 -0700 (PDT)
In-Reply-To: <4644E9E5.3000402@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: William Thompson <wt@electro-mechanical.com>, Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> +            if (class == ATA_DEV_ATA)
>> +                class = ATA_DEV_ATAPI;
>> +            else
>> +                class = ATA_DEV_ATA;
> 
> 
> the 'else' branch is obviously redundant

Why?  We can also fallback from ATAPI to ATA.

-- 
tejun
