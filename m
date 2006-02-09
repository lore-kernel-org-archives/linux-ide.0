From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata-dev: Fix array index value in ata_rwcmd_protocol()
Date: Thu, 09 Feb 2006 04:26:24 -0500
Message-ID: <43EB0AC0.1010807@pobox.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AD00.8070900@tw.ibm.com> <43E9ADD7.6070406@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:61086 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030326AbWBIJ01 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 04:26:27 -0500
In-Reply-To: <43E9ADD7.6070406@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Patch 1/4:
> 
>   - Fix the array index value in ata_rwcmd_protocol() for the added FUA commands.
> 
> For your review, thanks.
> 
> Albert
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

applied 1-4


