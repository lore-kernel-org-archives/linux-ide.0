From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC] libata-dev: make the returned err_mask more accurate
Date: Thu, 06 Apr 2006 15:34:37 +0800
Message-ID: <4434C48D.3010604@tw.ibm.com>
References: <4434BD0C.9080302@tw.ibm.com> <20060406071442.GF31998@htj.dyndns.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:48553 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932134AbWDFHev
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Apr 2006 03:34:51 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k367Ykl4008108
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 03:34:46 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k367VOOS125780
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 01:31:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k367Ye21026787
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 01:34:40 -0600
In-Reply-To: <20060406071442.GF31998@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Tejun Heo wrote:
 > 
> I don't think putting these two functions into libata.h as inlines is
> a good idea.  As currently there are no users, it would be better to
> put them where they are used as static functions and export it later
> as necessary.
> 

You are right. Will revise it.



