From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [opensuse-kernel] SSD / filesystem / TRIM
Date: Tue, 31 Aug 2010 08:36:16 -0400
Message-ID: <4C7CF740.9040907@teksavvy.com>
References: <4C759825.60503@web.de>	<AANLkTimrOOPExu+hU9wNubT3wgJWwUxMwjREn2p=x-qT@mail.gmail.com>	<4C7A2949.8070606@web.de> <AANLkTinNt83RYu+ssRHzLT=E+Nk5kTk4Q+sfxQk5SP4+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:35662 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755941Ab0HaMgS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2010 08:36:18 -0400
In-Reply-To: <AANLkTinNt83RYu+ssRHzLT=E+Nk5kTk4Q+sfxQk5SP4+@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Thomas Hertweck <Thomas.Hertweck@web.de>, opensuse-kernel@opensuse.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On 10-08-30 03:14 PM, Greg Freemyer wrote:
>
> Mark, any thoughts why it didn't work.  Have you added anything
> relevant to hdparm since v.9.28 that would help?


It probably failed because it couldn't cope with the long trimlist
that was fed to it.  That's the drive's fault, really.

But the latest hdparm/wiper from sourceforge should fare better,
as it now defaults to assuming the SSD cannot handle long trim lists.

Cheers
