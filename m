From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: On the subject of DRQ and EH...
Date: Sat, 01 Apr 2006 17:13:40 +0800
Message-ID: <442E4444.1050806@tw.ibm.com>
References: <442DC9E7.5000203@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:46808 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750808AbWDAJOG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Apr 2006 04:14:06 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k319Dw6v002433
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 04:13:58 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k319Aiku182424
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 02:10:44 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k319DwBs022970
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 02:13:58 -0700
In-Reply-To: <442DC9E7.5000203@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> grep for try_to_flush_leftover_data in drivers/ide.
> 

Thanks for the pointer. Patch to follow.

--
Albert


