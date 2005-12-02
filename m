From: Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: Promise SATA oops
Date: Fri, 2 Dec 2005 11:51:09 -0800
Message-ID: <20051202195109.GE3677@vitelus.com>
References: <20051202045853.GD3677@vitelus.com> <438FDB9D.2030201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751000AbVLBTvM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <438FDB9D.2030201@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Dec 02, 2005 at 12:29:01AM -0500, Jeff Garzik wrote:
> This should be fixed in 2.6.15-rcX...

Still isn't stable. It froze within hours after announcing in all
terminals that it was disabling a certain IRQ. Now the RAID is so
degraded that root can't even be mounted. Was the Promise controller a
bad choice for a reliable setup?

I may not have time to look at this further until late next week, but
I'll follow up with whatever I learn.
