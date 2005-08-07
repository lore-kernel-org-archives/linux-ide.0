From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] libata-dev: pdc2027x mdelay() problem fix for
	power5 micro-partitioning
Date: Sun, 07 Aug 2005 11:18:14 +0200
Message-ID: <1123406295.30257.104.camel@gaston>
References: <42F24DBE.0@tw.ibm.com>  <42F251C2.8090409@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:10707 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751341AbVHGJZA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Aug 2005 05:25:00 -0400
In-Reply-To: <42F251C2.8090409@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Fri, 2005-08-05 at 01:34 +0800, Albert Lee wrote:
> Jeff,
> 
> Patch 2/3: pdc2027x mdelay() problem fix for micro-partitioning
> 
> Description:
>    The mdelay(100) does not delay exactly 100 ms on IBM power5 machines when the power5 CPU micro-partitioning feature is turned on.
> Ex. If micro-partitioning is set to use 0.1 of the CPU time, mdelay(100) will delay about 1 sec instead of 100ms.

How so ? mdelay() implementation on ppc64 uses the timebase register, it
should tick at a constant speed and be calibrated at boot.

Ben.

