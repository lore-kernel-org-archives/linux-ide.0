From: Tejun Heo <tj@kernel.org>
Subject: Re: Port Multiplier access with Sil 3124
Date: Wed, 11 Feb 2009 11:12:22 +0900
Message-ID: <49923406.60501@kernel.org>
References: <498F42B6.8030607@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58044 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbZBKCMd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2009 21:12:33 -0500
In-Reply-To: <498F42B6.8030607@tlinx.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-ide@vger.kernel.org

Linda Walsh wrote:
> It seems there should be a linux util to manage the "container",
> 'sil57xx'  --  I take it is not used for RAID-only config?

sil57xx should generally work fine as PMP device.  There has been some
detection related problem with recent firmwares which isn't fixed yet
but it should generally work.  The hardest part is to put the chip
into vanilla PMP mode.  The reference board I have has this rotary
switch and I need to put it into JBOD mode and press another small
mode-set switch to actually make the transition.

Can you post kernel boot log?

--
tejun
