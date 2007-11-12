From: Thomas Rohwer <tr@tng.de>
Subject: Re: Hang during boot in piix_init_pcs (ata_piix.c) with macbook pro
Date: Mon, 12 Nov 2007 23:12:58 +0100
Message-ID: <4738CFEA.80200@tng.de>
References: <47371586.9090409@tng.de> <47386F3E.8000906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2-1.tng.de ([213.178.66.95]:48143 "EHLO smtp2.tng.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758226AbXKLWNB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Nov 2007 17:13:01 -0500
In-Reply-To: <47386F3E.8000906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, "Gaston, Jason D" <jason.d.gaston@intel.com>

Hello,

> Yes, adding a separate entry for ich8m is the correct approach w/
> port_enable=1 seems like the correct approach.  Does it fix the problem?

thanks for the information. I tried it now, and at least my hard drive is still
working and the pcs is not updated anymore. I will report after using this version
for a few days if it fixes the matter.

Sincerely,

Thomas Rohwer

