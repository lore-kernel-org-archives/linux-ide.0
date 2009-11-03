From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Enable SB600 64bit DMA on MSI K9A2 Platinum v2
Date: Tue, 03 Nov 2009 18:10:09 +0900
Message-ID: <4AEFF371.6050105@kernel.org>
References: <65a6ef750911030106o2d6a6391o60fac0f2b75cbcc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51470 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbZKCJKl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Nov 2009 04:10:41 -0500
In-Reply-To: <65a6ef750911030106o2d6a6391o60fac0f2b75cbcc4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Mark Nelson wrote:
> Like the Asus M2A-VM, MSI's K9A2 Platinum (MS-7376) can also support 64bit
> DMA. It is a new enough board that all the BIOS releases work correctly with
> 64bit DMA enabled.
> 
> Signed-off-by: Mark Nelson <mdnelson8@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thank you very much for the marticulous testing.

-- 
tejun
