From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata:pata_atiixp: Don't use unconnected secondary port
 on SB600
Date: Tue, 2 Jan 2018 06:56:49 -0800
Message-ID: <20180102145608.GA3668920@devbig577.frc2.facebook.com>
References: <4b3d1364126.4c1d107e@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:45856 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeABO46 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2018 09:56:58 -0500
Received: by mail-io0-f177.google.com with SMTP id e20so6465968iof.12
        for <linux-ide@vger.kernel.org>; Tue, 02 Jan 2018 06:56:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4b3d1364126.4c1d107e@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>
Cc: linux-ide@vger.kernel.org

Hello, Darren.

On Sun, Dec 31, 2017 at 09:11:05PM +0000, Darren Stevens wrote:
>     The AMD SB600 southbridge has an PATA IDE interface, but the
>     secondary port has no physical connections, so is disabled in
>     the PCI header which makes it appear as a legacy port.

How sure are you about the secondary port never being used?  Given the
age of the device and that this has been like this the whole time, I'd
prefer if the workaround were more specific - ie. mark it dummy only
on the specific machines that are known to be broken.  That said, if
we know with certainty that the secondary port is never used, sure.

Thanks.

-- 
tejun
