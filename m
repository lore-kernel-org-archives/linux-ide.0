From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: ide/dma not working from 2.6.19 to 2.6.21
Date: Tue, 26 Jun 2007 13:05:43 +0800
Message-ID: <46809EA7.5090005@tw.ibm.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com>	<467A9923.6010203@ru.mvista.com>	<467F5127.4060006@tw.ibm.com> <20070625101009.48269d6e@the-village.bc.nu>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:41921 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbXFZFFz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2007 01:05:55 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5Q55sqP012361
	for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2007 01:05:54 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5Q55sP7267160
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 23:05:54 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5Q55rLL011305
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 23:05:54 -0600
In-Reply-To: <20070625101009.48269d6e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bahadir Balban <bahadir.balban@gmail.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Alan Cox wrote:
>>Reloading the pata_pdc2027x module then the problem goes away.
>>I guess maybe somehow mdelay() is not as precise as before...
> 
> 
> It's not the most accurate of things once power management and the like
> get invovled. HT doesn't help it either. You should have get much more
> accurate timing information if you query gettimeofday before/after and do
> a few loops.
> 

Thanks for the advice. Patch to follow.

--
albert

