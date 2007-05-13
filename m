From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [1/2] 2.6.22-rc1: known regressions
Date: Sun, 13 May 2007 11:19:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705131118160.3212@alien.or.mcafeemobile.com>
References: <46475595.4050105@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:4833 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322AbXEMSTi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 May 2007 14:19:38 -0400
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S22BE9C> for <linux-ide@vger.kernel.org> from <davidel@xmailserver.org>;
	Sun, 13 May 2007 14:19:37 -0400
In-Reply-To: <46475595.4050105@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Antonino Ingargiola <tritemio@gmail.com>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-fsdevel@vger.kernel.org, xfs-masters@oss.sgi.com, Jeremy Fitzhardinge <jeremy@goop.org>, David Chinner <dgc@sgi.com>, Charles Gagalac <charle97@yahoo.com>

On Sun, 13 May 2007, Michal Piotrowski wrote:

> Subject    : applications under wine freezes
> References : http://bugzilla.kernel.org/show_bug.cgi?id=8462
> Submitter  : Charles Gagalac <charle97@yahoo.com>
> Caused-By  : Davide Libenzi <davidel@xmailserver.org>
>              commit 6192bd536f96c6a0d969081bc71ae24f9319bfdc
> Handled-By : Davide Libenzi <davidel@xmailserver.org>
> Status     : problem is being debugged

This has been fixed. Confirmed by myself and Charles Gagalac. Patches have 
been sent to Andrew.



- Davide


