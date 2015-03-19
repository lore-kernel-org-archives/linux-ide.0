From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_mv: add proper definitions for LP_PHY_CTL
 register values
Date: Thu, 19 Mar 2015 14:21:09 -0400
Message-ID: <20150319182109.GB19657@htj.duckdns.org>
References: <1426772197-17908-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:58499 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbbCSSVN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Mar 2015 14:21:13 -0400
Received: by mail-vc0-f180.google.com with SMTP id hy10so5222936vcb.11
        for <linux-ide@vger.kernel.org>; Thu, 19 Mar 2015 11:21:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426772197-17908-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-ide@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Simon Guinot <simon.guinot@sequanux.org>, Christophe Vu-Brugier <cvubrugier@lacie.com>

On Thu, Mar 19, 2015 at 02:36:37PM +0100, Thomas Petazzoni wrote:
> Commit 9013d64e661fc ("ata: sata_mv: fix disk hotplug for Armada
> 370/XP SoCs") added some manipulation of the LP_PHY_CTL register, but
> using magic values. This commit changes the code to use proper
> definitions for the LP_PHY_CTL register, which allows to document what
> the different bits are doing.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to libata/for-4.1.

Thanks.

-- 
tejun
