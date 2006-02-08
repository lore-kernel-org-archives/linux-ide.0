From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: irq-pio branch updated with Tejun's patches
Date: Wed, 08 Feb 2006 16:25:04 +0800
Message-ID: <43E9AAE0.8020302@tw.ibm.com>
References: <43DA2CFB.4010605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:1236 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161070AbWBHIZP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Feb 2006 03:25:15 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k188PEEr007572
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 03:25:14 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k188NAn7201980
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:23:10 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k188PEa8016790
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:25:14 -0700
In-Reply-To: <43DA2CFB.4010605@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Jeff Garzik wrote:
> 
> I updated the libata irq-pio branch with Tejun's patches.  I would
> appreciate it if you could check my work, and make sure that everything
> continues to function properly.
> 

Sorry for the late reply.
Still checking Tejun's patches, especially the EH vs polling PIO racing fix.

Fixed minor compiliation problem in the irq-pio branch with Tejun and your patches.
Will submit those minor patches first.

Albert


