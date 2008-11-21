From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA timeouts on old thinkpad
Date: Fri, 21 Nov 2008 00:37:23 +0000
Message-ID: <20081121003723.03bcef7e@lxorguk.ukuu.org.uk>
References: <20081121002521.GA12626@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40237 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755108AbYKUAhV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Nov 2008 19:37:21 -0500
In-Reply-To: <20081121002521.GA12626@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, 21 Nov 2008 00:25:21 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

> Hi,
> 
> Last weekend I upgraded my old Thinkpad from Fedora Core 2 to F9
> (a 2.6.9 kernel to a 2.6.25 kernel).  The old 2.6.9 kernel was
> using the IDE drivers, and there have been no issues with IDE on
> this hardware until this upgrade.

Can you double the timeouts for block I/O commands. The libata core uses
30 second timeouts for a lot of stuff and some PATA drives really do want
60.

Other than that there really isn't any difference in the settings the two
drivers use as they are all written up exactly in the Intel docs.
