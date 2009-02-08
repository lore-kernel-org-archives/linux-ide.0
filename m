From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-sff: fix 32-bit PIO regression
Date: Sun, 8 Feb 2009 20:11:25 +0000
Message-ID: <20090208201125.49326bd2@lxorguk.ukuu.org.uk>
References: <200902082253.07438.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37010 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752153AbZBHUOQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Feb 2009 15:14:16 -0500
In-Reply-To: <200902082253.07438.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl

On Sun, 8 Feb 2009 23:53:07 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> one last  time when there are exactly 3 trailing bytes.  Oh, and stop pointless
> swapping bytes to and fro as well by using io*_rep() which shouldn't byte-swap.

Nice - thats a very sneaky and clean way to do it but probably should be
commented or someone will "optimise" it one day ..
