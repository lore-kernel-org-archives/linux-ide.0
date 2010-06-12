From: maximilian attems <max@baikonur.stro.at>
Subject: Re: Bug#585556: More ata_piix spurious IRQs
Date: Sat, 12 Jun 2010 21:06:14 +0200
Message-ID: <20100612190613.GH9869@baikonur.stro.at>
References: <20100611222746.37b5efa6@server.gazypan.dyndns.org> <1276298006.14011.149.camel@localhost> <4C13C4D5.5080300@kernel.org> <20100612194944.750682d7@server.gazypan.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:34500 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab0FLTOw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jun 2010 15:14:52 -0400
Content-Disposition: inline
In-Reply-To: <20100612194944.750682d7@server.gazypan.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeanseb <jeanseb.valette@free.fr>, 585556@bugs.debian.org
Cc: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, linux-ide@vger.kernel.org

On Sat, Jun 12, 2010 at 07:49:44PM +0200, jeanseb wrote:
> Hi,
> the Drive is recognizes by bios and works (fine enough to install
> debian).
> 
> thanks

could you post dmesg of install before reboot.
probably the installer still uses the old ide stack.

thanks
