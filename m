From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pmp: add quirk for Marvell 4140 SATA PMP
Date: Tue, 14 Jul 2015 17:46:21 -0400
Message-ID: <20150714214621.GH2273@mtj.duckdns.org>
References: <1435673389-10729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36058 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbbGNVqY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 17:46:24 -0400
Received: by qgy5 with SMTP id 5so10419889qgy.3
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2015 14:46:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435673389-10729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-ide@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>

On Tue, Jun 30, 2015 at 04:09:49PM +0200, Thomas Petazzoni wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> This commit adds the necessary quirk to make the Marvell 4140 SATA PMP
> work properly. This PMP doesn't like SRST on port number 4 (the host
> port) so this commit marks this port as not supporting SRST.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to libata/for-4.2-fixes w/ stable cc'd.

Thanks.

-- 
tejun
