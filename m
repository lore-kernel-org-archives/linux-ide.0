From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci_start_engine compliance with AHCI spec
Date: Thu, 4 Aug 2011 11:44:19 +0200
Message-ID: <20110804094419.GA2731@htj.dyndns.org>
References: <CAN8TOE9CCSiS2koyx=UsZj=9KwaWZW5yDjUUqgJf2=qZU70k1w@mail.gmail.com>
 <20110713131407.GN2872@htj.dyndns.org>
 <CAN8TOE9Rjujf9aLQGONDULNasFiQmVkiUPWUDX=Vf0Nx2pka7w@mail.gmail.com>
 <20110721084917.GE3455@htj.dyndns.org>
 <CAN8TOE_dCg6Wi_trE97hXjBPnZi4jpLyoeUEVrbMpgDH-BwKWA@mail.gmail.com>
 <20110722090317.GH2622@htj.dyndns.org>
 <CAN8TOE8ZoE0xRvLPhDZtKZSwXg1mQLGtp8f2C75S+XuCrFM1YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48509 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab1HDJoY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Aug 2011 05:44:24 -0400
Content-Disposition: inline
In-Reply-To: <CAN8TOE8ZoE0xRvLPhDZtKZSwXg1mQLGtp8f2C75S+XuCrFM1YA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-ide@vger.kernel.org, Valdis.Kletnieks@vt.edu, "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Garzik <jgarzik@pobox.com>, Michael Leun <lkml20100708@newton.leun.net>, linux-kernel@vger.kernel.org, Jian Peng <jipeng2005@gmail.com>, Kevin Cernekee <cernekee@gmail.com>

Hello,

On Tue, Aug 02, 2011 at 05:06:13PM -0700, Brian Norris wrote:
> Can DRQ be set from 0->1 without a software-initiated action? I didn't
> think it was directly tied to PHY events, and so we can fairly well
> predict that it will remain 0.

Sure it can.  It's updated by Register D2H FISes sent by the device.
It can change after a PHY event; otherwise, I don't think it would get
set during init without any command in flight, right?

> Yes, I believe the hardware designers know how buggy this is...but
> it's still worth some effort to fix the software as well as possible
> for current hardware behavior.

Yeap, sure, let's get it working for majority of cases.  I just wanted
to point out that the hardware eventually needs to be fixed.

Thanks.

-- 
tejun
