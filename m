From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/12] libata: convert drivers with combined SATA/PATA
 ports to new init model
Date: Sat, 10 Mar 2007 14:02:53 +0900
Message-ID: <45F23BFD.1050500@gmail.com>
References: <200703092235.l29MZlMx007319@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:48776 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767822AbXCJFCy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 00:02:54 -0500
Received: by nz-out-0506.google.com with SMTP id s1so958476nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 21:02:53 -0800 (PST)
In-Reply-To: <200703092235.l29MZlMx007319@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-ide@vger.kernel.org

Hello,

Mikael Pettersson wrote:
> I don't object to the new init model in principle.
> My only reservation here is that you are folding what
> logically are separate changes into one big change to
> sata_promise, and that makes the patch more difficult
> to review (and regressions more difficult to trace).
> 
> I would like to do the SATA/PATA splitup into distinct
> operations as a separate first step, with you doing the
> new init model adaptation in a followup step.

I don't think SATA/PATA splitup is so easy if you don't have new init
model.  That's why the driver looks the way it does now.  Maybe the
other way around is easier - convert to new init model first then split
SATA/PATA.  I'll try to split the patch.

> Also, at least the error handler changes would seem to
> be in conflict with Alan's cable type changes.

Yeap, the two patchsets are bound to conflict, but they shouldn't be
difficult to merge.  If Jeff merges cable patchset first, I'll update my
patchset against the new #upstream, if it happens the other way around,
Alan will, so no biggy.

Thanks.

-- 
tejun
