From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 13:16:36 +0000
Message-ID: <20091119131636.15800a11@linux.intel.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<20091118184125.623e063d@lxorguk.ukuu.org.uk>
	<200911182007.07405.bzolnier@gmail.com>
	<200911182056.16517.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:21448 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752095AbZKSNdi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 08:33:38 -0500
In-Reply-To: <200911182056.16517.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Only pata_hpt37x has broken cable detection while pata_hpt3x2n is
> okay. ;)

I think you have that backwards according to the vendor drivers. 3x2n
looks like it needs adjusting.
 

