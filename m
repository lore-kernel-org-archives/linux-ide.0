From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Possible regression when going from 2.6.26 to 2.6.32
Date: Fri, 29 Oct 2010 17:40:53 -0400
Message-ID: <4CCB3F65.60302@teksavvy.com>
References: <20101029082612.GA6525@lenny.spiney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:32591 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761967Ab0J2Vk4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Oct 2010 17:40:56 -0400
In-Reply-To: <20101029082612.GA6525@lenny.spiney.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wolfgang Karall <lists+linux-ide@karall-edv.at>
Cc: linux-ide@vger.kernel.org, saeed.bishara@gmail.com, mlord@pobox.com, tbm@cyrius.com

On 10-10-29 04:28 AM, Wolfgang Karall wrote:
> when upgrading my QNAP TS-409 device (Marvell Orion based) from kernel
> version 2.6.26 (current Debian 5.0/lenny) to 2.6.32 (Martin Michlmayr's
> repository at http://people.debian.org/~tbm/orion who's also pointed me
> to this list and recipients) only 2 out of the 4 HDD drives connected get
> recognized.
>
> Attached are dmesg outputs from both a successful boot with 2.6.26
> showing all 4 drives and a failed boot with 2.6.32 showing only 2
> drives.


Try again with a 2.6.35 kernel -- several sata_mv regressions fixed in there.
