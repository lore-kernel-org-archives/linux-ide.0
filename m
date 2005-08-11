From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] libata-dev: pdc2027x mdelay() problem fix for
	power5 micro-partitioning
Date: Thu, 11 Aug 2005 10:36:20 +0200
Message-ID: <1123749380.20143.12.camel@gaston>
References: <42F24DBE.0@tw.ibm.com> <42F251C2.8090409@tw.ibm.com>
	 <42FAC04F.4060405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:31373 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030223AbVHKIhK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 04:37:10 -0400
In-Reply-To: <42FAC04F.4060405@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, 2005-08-10 at 23:04 -0400, Jeff Garzik wrote:

> mdelay() should be investigated as to why its not working on your 
> platform.  do_gettimeofday() is -less- granular and accurate than 
> mdelay(), usually.

Agreed. mdelay() should have worked.

Ben.

