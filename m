From: Andres Meyer <andres.meyer@computer.org>
Subject: Re: Opteron SATA machine check exception (32bit)
Date: Sun, 21 Mar 2004 22:44:57 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403212244.57083.andres.meyer@computer.org>
References: <200403100006.36405.andres.meyer@computer.org> <200403112258.33170.andres.meyer@computer.org> <405C2C58.5090901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout.hispeed.ch ([62.2.95.247]:53139 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261321AbUCUVpN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Mar 2004 16:45:13 -0500
Received: from mail.cputoasters.com (217-162-8-144.dclient.hispeed.ch [217.162.8.144])
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id i2LLjBW0020039
	for <linux-ide@vger.kernel.org>; Sun, 21 Mar 2004 22:45:11 +0100
Received: from kyodai.prv (kyodai.prv [192.168.0.224])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.cputoasters.com (Postfix) with ESMTP id E0CE42B
	for <linux-ide@vger.kernel.org>; Sun, 21 Mar 2004 22:44:33 +0100 (CET)
In-Reply-To: <405C2C58.5090901@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Saturday 20 March 2004 12.34, Jeff Garzik wrote:
> Does "nomce" fix the mce?  :)  Some mce-related fixes are headed to
> Linus, I hear...

It looks like 2.6.5-rc2 fixes the problem by not creating mces anymore. It 
probably was the UDMA6 & Marvel SATA dongle problem. I also tried to connect 
them to a highpoint rr1820 controller (I had to hack the openbuild drivers to 
adjust for some recent API changes). There it began working when not using 
ATA133 but eg ATA66.

Thanks for your help,
Andres
