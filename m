From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] libata: add missing CONFIG_PM in LLDs
Date: Fri, 2 Mar 2007 12:57:32 +0000
Message-ID: <20070302125732.2eb9e67e@lxorguk.ukuu.org.uk>
References: <20070302083001.GK20322@htj.dyndns.org>
	<20070302083126.GL20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33738 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423040AbXCBLx0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 06:53:26 -0500
In-Reply-To: <20070302083126.GL20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Fri, 2 Mar 2007 17:31:26 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Add missing #ifdef CONFIG_PM conditionals around all PM related parts
> in libata LLDs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>


Ughhhhhhhhh...

Can we not just provide dummy methods ?

Alan


