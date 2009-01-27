From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH 2/5] pata-rb532-cf: replace rb532_pata_finish_io()
Date: Tue, 27 Jan 2009 14:36:53 +0100
Message-ID: <20090127133329.3A3F04CD65@mail.nwl.cc>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net> <1232469660-22335-1-git-send-email-n0-1@freewrt.org> <1232469660-22335-2-git-send-email-n0-1@freewrt.org> <20090120164259.54630400E125@mail.nwl.cc> <497EB438.5070807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:59361 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275AbZA0Ndg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 08:33:36 -0500
Content-Disposition: inline
In-Reply-To: <497EB438.5070807@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, florian@openwrt.org

Hi,

On Tue, Jan 27, 2009 at 02:14:00AM -0500, Jeff Garzik wrote:
> ACK patches 2-5, but they don't apply to upstream (plus patch #1)

the problem was the original patch regarding 32bit IO, which I forgot to
remove prior to creating the discussed changes. I'll reply to this email
with patches 2-5, which should now cleanly apply to current ide-2.6.

Greetings, Phil
