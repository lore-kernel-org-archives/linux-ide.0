From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sil4726 ahci driver initialization sequence
Date: Fri, 30 Nov 2007 09:48:27 +0900
Message-ID: <474F5DDB.2090408@gmail.com>
References: <5501535d0711290927u613e61d1h2368eebc26bd4982@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:33478 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761736AbXK3Ase (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 19:48:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1751653rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 16:48:34 -0800 (PST)
In-Reply-To: <5501535d0711290927u613e61d1h2368eebc26bd4982@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjoern Olausson <lkmlist@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Bjoern Olausson wrote:
> I managed to install WinXP  and I think I got the driver to work on WindowsXP.
> The installation was ony possible in IDE Enhaced mode. I wasn't able
> to feed XP the Intel Matrix Storage controller during installation to
> use XP wiith AHCI mode.
> 
> I searched around for instructions on how to upgrade the jmb firmware
> but without luck. Thougt I upgraded the BIOS of the P5W-DH Mainboard
> to the latest one (Actually I don't know what Asus changed [Asus does
> not provide changelogs])

JMB?  That's Jmicron.  What should be updated is the SIMG4726 firmware.

-- 
tejun
