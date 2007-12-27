From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: NCQ spurious completion
Date: Thu, 27 Dec 2007 21:59:50 +0000
Message-ID: <20071227215950.3148d1f8@the-village.bc.nu>
References: <4773D534.9060609@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54811 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752068AbXL0WII (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 17:08:08 -0500
In-Reply-To: <4773D534.9060609@club-internet.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugo Grostabussiat <hugo.grostabussiat@club-internet.fr>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Thu, 27 Dec 2007 17:39:16 +0100
Hugo Grostabussiat <hugo.grostabussiat@club-internet.fr> wrote:

> Hello.
> I am not a native English speaker, so sorry for my poor English.

Your English is fine and easy to understand.

 disabled).
> 
> That's why I suggest drive Hitachi HTS541616J9SA00 revision SB4OC7DP to
> be added to the blacklist.

It turns out the bug is caused by a Linux bug not a drive bug and it has
been fixed in 2.6.24-rc properly. The blacklist entries for it have also
been removed.

Alan
