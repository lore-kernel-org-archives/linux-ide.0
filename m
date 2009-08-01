From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: Bug report (suspend to disk is broken in 2.6.29+ with EIDE drive)
Date: Sat, 01 Aug 2009 18:32:36 +0200
Message-ID: <4A746E24.1050401@gmail.com>
References: <937390.49428.qm@web111003.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:8346 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbZHAQcr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 12:32:47 -0400
In-Reply-To: <937390.49428.qm@web111003.mail.gq1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Watts <akwatts@ymail.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Andrew Watts wrote:
> Description: s2disk worked in 2.6.28 and no longer works in 2.6.30.2
> (s2disk here means: echo disk > /sys/power/state); screen blanks but
> system hangs.
> 
> Bisection reveals that the problem commit has hash:
> 295f00042aaf6b553b5f37348f89bab463d4a469.
> 
> ~Andy
> 
> PS I wrote some months ago about a thermal problem on my HW with
> 2.6.28 (needed noapic, nolapic to have it not run hot @ idle).
> This problem has disappeared in 2.6.30.2. Any devs have an idea what
> commit fixed this?

Adding CCs
