From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_via oops on copying files?
Date: Tue, 19 May 2009 21:10:52 +0100
Message-ID: <20090519211052.55d01236@lxorguk.ukuu.org.uk>
References: <20090519091655.c0bed8b1fc13fcbc567bd8d4c339afd4.8d107e4704.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38171 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751979AbZESUKH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 16:10:07 -0400
In-Reply-To: <20090519091655.c0bed8b1fc13fcbc567bd8d4c339afd4.8d107e4704.wbe@email.secureserver.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Astals Cid <albert@miraveo.com>
Cc: linux-ide@vger.kernel.org

On Tue, 19 May 2009 09:16:55 -0700
"Albert Astals Cid" <albert@miraveo.com> wrote:

> 
> Please CC me, i'm not in the list.
> 
> Not sure if this or bugzilla is preferred, so doing both, shout me if i
> should wait on bugzilla.

None of this looks IDE related - the first looks like an IRQ routing
problem which is usually but not always a buggy BIOS. The random crashes
look like faulty hardware but its always hard to tell hardware and
software bugs.

Does the system pass memtest86 for 24 hours ?

