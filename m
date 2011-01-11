From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI support Port Multiplier problem.
Date: Tue, 11 Jan 2011 15:39:19 +0100
Message-ID: <20110111143919.GF30607@htj.dyndns.org>
References: <20110107212537.GH7355@mtj.dyndns.org>
 <55871.3142.qm@web74203.mail.tp2.yahoo.com>
 <4D2BB855.5070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48664 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab1AKOjY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jan 2011 09:39:24 -0500
Received: by bwz15 with SMTP id 15so20145787bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 11 Jan 2011 06:39:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2BB855.5070703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Luo Dislo <dislo_b_j@yahoo.com.tw>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

On Mon, Jan 10, 2011 at 07:54:29PM -0600, Robert Hancock wrote:
> I suspect that retrying with PMP=0 if the softreset with PMP=15
> failed to acquire a signature is likely the thing to do.

Of the non-platform ones, sb600 is the only one with this problem and
the workaround will unnecessarily lengthen response time for other
controllers.  I'd suggest implementing it as a quirk in libahci.c and
applying it only to the broken controllers.

Thanks.

-- 
tejun
