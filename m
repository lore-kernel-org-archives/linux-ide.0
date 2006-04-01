From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC] libata: disable interrupts before soft reset
Date: Sat, 01 Apr 2006 21:36:58 +0800
Message-ID: <442E81FA.9020300@tw.ibm.com>
References: <442CFE96.1040203@tw.ibm.com> <20060331103210.GB13172@htj.dyndns.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:36770 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751518AbWDANhP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Apr 2006 08:37:15 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k31Db9JT031396
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 08:37:09 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k31DeG3O179048
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 06:40:18 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k31Db66T012309
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 06:37:07 -0700
In-Reply-To: <20060331103210.GB13172@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

Tejun Heo wrote:

> 
> Please hold this off.  This issue is handled by new EH.
> 
> This problem is bigger than just during reset.  Any error condition
> which leaves the device and/or controller has potential to cause
> similar problems or worse (e.g. data corruption, screaming
> interrupts).  New EH handles this by freezing ports when
> device/controller enters unknown state.  The controller is thawed
> after EH reset is complete.  The same mechanism applies to probing.
> All ports are started frozen.  Only after initial reset is complete,
> ports get thawed.
> 
> It's been a loooooong week but I'm splitting the patches now.  :)
> 

Great. :)
Will test the drive again when the new EH is out.

Thanks,

Albert

