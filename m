From: Tejun Heo <htejun@gmail.com>
Subject: Re: ahci: factor out AHCI enabling and enable AHCI before reading
 CAP
Date: Fri, 18 Jan 2008 18:37:28 +0900
Message-ID: <47907358.6080306@gmail.com>
References: <477F902D.2000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:36954 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbYARJhd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 04:37:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so836039rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 01:37:33 -0800 (PST)
In-Reply-To: <477F902D.2000400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Factor out AHCI enabling into ahci_enable_ahci() and enabling AHCI
> before reading CAP in ahci_save_initial_config() as the spec requires
> enabling AHCI mode before accessing any other registers.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Ping.  Sorry about the missing [PATCH] header.

-- 
tejun
