From: Andrei Martynov <andrei.martynov@web.de>
Subject: Re[2]: porting IDE patches to PATA driver
Date: Thu, 25 Jun 2009 10:38:34 +0200
Message-ID: <14164712.20090625103834@web.de>
References: <323951117.20090625100956@web.de>
 <20090625092324.2dd4de5a@lxorguk.ukuu.org.uk>
Reply-To: Andrei Martynov <andrei.martynov@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:48254 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbZFYIii (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jun 2009 04:38:38 -0400
In-Reply-To: <20090625092324.2dd4de5a@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hi Alan,

Thursday, June 25, 2009, 10:23:24 AM, you wrote:

>> I'm porting Sigma IDE driver for EM85XX chipset from 2.4.17 to 2.6

> Are you trying to port it to the legacy IDE code in 2.6 or to libata ?

I'm trying to port it to libata. My PATA driver already supports EM8511
chipset but I constantly get errors on EM8500 chipset.

-- 
Best regards,
 Andrei                            mailto:andrei.martynov@web.de

