From: "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>
Subject: RE: [PATCH v5 3/3] ahci_platforms: add support for CNS3xxx SoC
 devices
Date: Mon, 10 Jan 2011 17:50:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373E1D99B__18588.1489575424$1294665418$gmane$org@dbde02.ent.ti.com>
References: <1294557970-654-1-git-send-email-mkl0301@gmail.com>
 <1294557970-654-4-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57339 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942Ab1AJNQi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 08:16:38 -0500
In-Reply-To: <1294557970-654-4-git-send-email-mkl0301@gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "mkl0301@gmail.com" <mkl0301@gmail.com>, "htejun@gmail.com" <htejun@gmail.com>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm->

> From: Mac Lin <mkl0301@gmail.com>
> 
> CNS3xxx override the softreset function of ahci_platform
> ahci_softreset by cns3xxx_ahci_softreset, which would retry
> ahci_do_softreset again with pmp=0 if
> pmp=15 failed, for the controller has problem receiving D2H
> Reg FIS of the different PMP setting of the previous sent H2D Reg FIS.
> 

Is this issue only with your ahci platform controller? I came across another 
thread here,

http://www.spinics.net/lists/linux-ide/msg39865.html  

Also, the ahci platform controller on Texas Instruments OMAP L138 platform 
behaves in a similar fashion. 

Currently I see only Cavium Networks, Faraday and TI using ahci platform 
controller and all 3 facing same issue.

Hence, should we fix this in ahci_platform.c conditionally using platform data, 
otherwise we will end-up adding file for every platform (just for one 
function). 

Thanks
Mansoor Ahamed