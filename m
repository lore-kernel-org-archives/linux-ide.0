From: Tejun Heo <htejun@gmail.com>
Subject: commit a258f183ee4e48e9352b408e8448467eebdc6cd2
Date: Wed, 02 Jan 2008 18:34:38 +0900
Message-ID: <477B5AAE.7070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:41325 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbYABJeo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 04:34:44 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5203091rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 01:34:43 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Happy new year, Jeff, Alan.

I'm curious why commit a258f183 got in?  We already deal with this
problem by executing SETXFER by polling.  That's better IMHO for two
reasons - no clutter in hot path && applies to drivers which use custom
interrupt handlers.

Thanks.

-- 
tejun
