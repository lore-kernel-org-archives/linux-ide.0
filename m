From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] sata_via: Implement hotplug for VT6421
Date: Thu, 25 Feb 2016 13:23:08 -0500
Message-ID: <20160225182308.GB6092@mtj.duckdns.org>
References: <1456417345-1843-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36015 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933114AbcBYSXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2016 13:23:11 -0500
Content-Disposition: inline
In-Reply-To: <1456417345-1843-1-git-send-email-linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-ide@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Thu, Feb 25, 2016 at 05:22:25PM +0100, Ondrej Zary wrote:
> Enable IRQ on hotplug and add an interrupt handler to handle it.

Applied to libata/for-4.6.

Thanks!

-- 
tejun
