From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] remove ata_cable_sata()
Date: Thu, 24 Apr 2008 15:50:25 +0100
Message-ID: <20080424155025.2bcf0f9b@the-village.bc.nu>
References: <20080421085131.GE26897@cs181133002.pp.htv.fi>
	<20080423192243.1f117215@the-village.bc.nu>
	<20080424104406.GB2559@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44959 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761939AbYDXPTT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 11:19:19 -0400
In-Reply-To: <20080424104406.GB2559@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> I thought that you could simply set .flags in a driver without needing 
> any helper for .cable_detect .

In some cases yes, but exporting the complete set provides a logical and
complete API for drivers in case they do need to do so.
