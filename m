From: "Andrew Nelless" <andrew@nelless.net>
Subject: Re: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Thu, 25 Oct 2007 12:13:59 +0100 (BST)
Message-ID: <35080.86.7.220.119.1193310839.squirrel@wmbeta.mxes.net>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net>
    <47207466.6030507@garzik.org>
Reply-To: "Andrew Nelless" <andrew@nelless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout-04.mxes.net ([216.86.168.179]:2643 "EHLO
	mxout-04.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbXJYLOB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 07:14:01 -0400
In-Reply-To: <47207466.6030507@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Thu, October 25, 2007 11:48, Jeff Garzik wrote:
> Really?  That's a showstopper bug, as swncq is supposed to be disabled
> by default.
>
> Jeff
>

Well I have sata_nv compiled in rather than a module loaded by initrd
(If thats even possible?) and passing "sata_nv.swncq=0" or "swncq=0"
to the kernel did nothing ("Gaah, my kernel params, they do nothing!")

I will post again shortly with a netconsole log from a fresh 2.6.24-rc1
build.




