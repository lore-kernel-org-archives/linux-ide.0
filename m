From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Thu, 24 Jan 2008 11:32:48 +0900
Message-ID: <4797F8D0.6060302@gmail.com>
References: <4794459C.3090200@gmail.com> <47944913.6000603@gmail.com>	 <4794CB8B.1070600@gmail.com> <4795545E.5010908@gmail.com>	 <864c1e490801222034w32cd8799h3600fb902a3d97e6@mail.gmail.com>	 <4796DC44.6010100@gmail.com>	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>	 <4797ECF3.5000306@gmail.com> <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:15054 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbYAXCcz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jan 2008 21:32:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so83005wah.23
        for <linux-ide@vger.kernel.org>; Wed, 23 Jan 2008 18:32:54 -0800 (PST)
In-Reply-To: <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Thomas Evans wrote:
> I hadn't tried that until just now - I have 2 3124 cards, 1 without
> internal connections.
> Just tried the 1 with internal sata ports - it fails in the same way on
> a single drive.

There are cable which have SATA connector on one side and e-SATA on the
other.  You can connect harddrives directly using such cables.  Can you
please post the failing log?

-- 
tejun
