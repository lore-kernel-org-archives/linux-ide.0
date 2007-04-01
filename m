From: Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: Silent corruption on AMD64
Date: Sat, 31 Mar 2007 21:39:06 -0700
Message-ID: <20070401043905.GV15189@vitelus.com>
References: <20070401012736.GT15189@vitelus.com> <20070401030315.GA24080@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vitelus.com ([63.99.9.247]:35719 "EHLO vitelus.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbXDAEjl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Apr 2007 00:39:41 -0400
Content-Disposition: inline
In-Reply-To: <20070401030315.GA24080@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Mar 31, 2007 at 08:03:16PM -0700, Jim Paris wrote:
> Since it shows up under heavy load that includes unrelated devices, I
> think ruling out hardware problems is important.  Some suggestions:

I've been able to narrow it down to the Realtek Ethernet card. I can't
reproduce the problem using onboard Ethernet, whereas the Realtek card
causes trouble in any slot. However, I still don't know whether it's a
hardware or software issue, or whether it's caused directly or
indirectly by the Realtek card.
