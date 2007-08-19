From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Sun, 19 Aug 2007 09:03:38 +0800
Message-ID: <46C796EA.3000904@tw.ibm.com>
References: <200708182058.l7IKwrcJ016820@harpo.it.uu.se> <46C763D1.7060801@garzik.org> <46C78B57.5070808@tw.ibm.com> <46C7948B.1080107@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:43260 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbXHSBEr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 21:04:47 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7J14J29008972
	for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 21:04:19 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7J1490g040222
	for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 19:04:19 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7J148uT019224
	for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 19:04:09 -0600
In-Reply-To: <46C7948B.1080107@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: albertl@mail.com, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Jeff Garzik wrote:
> Albert Lee wrote:
> 
>> The first rmb() is to make sure bccrl is read before bccrlv for later
>> (bccrl >= bccrlv) check since both reading the same memory address.
> 
> 
> That's already guaranteed without the rmb(), AFAICS.
> 

Hmm, thanks for the advice. Will remove both rmb()s.
Will also remove the now unused (pll_clock < 0) check from pdc_hardware_init()
and test/verify Mikael's patch when I go back to office tomorrow.

--
albert

