From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Wed, 14 Mar 2007 17:01:43 +0800
Message-ID: <45F7B9F7.7060000@tw.ibm.com>
References: <45F5465F.6050709@gmail.com> <45F55E21.4030208@garzik.org> <45F7AC3E.20700@tw.ibm.com> <45F7AF0A.1030204@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:38828 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933903AbXCNJBz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 05:01:55 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2E91tPT018626
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 05:01:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2E91sOe026516
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 03:01:55 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2E91rtb011335
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 03:01:54 -0600
In-Reply-To: <45F7AF0A.1030204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, paul@paulbristow.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislav Brabec <sbrabec@novell.com>

Tejun Heo wrote:

> 
> 
> Hmmm... weird.  Your drive bears the same model name as Stanislav's.  I
> don't think the low level driver is causing the difference.  They both
> use the standard libata HSM implementation.  Any ideas?  Stanislav, can
> you try to connect that zip drive to another IDE controller?
> 

Maybe it's also worth a try to replace the medium, cable or even the
drive itself to rule out the possibility of hardware problem.

--
albert

