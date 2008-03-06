From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem with ahci and a external sata disk
Date: Thu, 06 Mar 2008 16:53:04 +0900
Message-ID: <47CFA2E0.5030304@gmail.com>
References: <200802191646.39277.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:38938 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbYCFHxO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 02:53:14 -0500
Received: by rn-out-0910.google.com with SMTP id v46so803355rnb.15
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 23:53:14 -0800 (PST)
In-Reply-To: <200802191646.39277.jareguero@telefonica.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jose Alberto Reguero <jareguero@telefonica.net>
Cc: linux-ide@vger.kernel.org

Jose Alberto Reguero wrote:
> When I try to make a ext3 fs in the disk I got a lot of erros:

Can you please try 2.6.25-rc4 and see whether it behaves any
differently.  The initial errors should be about the same but EH should
slow the PHY to 1.5Gbps quickly and that seems to solve many PHY related
problems on eSATA connectors.

Thanks.

-- 
tejun
