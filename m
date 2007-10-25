From: "Andrew" <andrew@nelless.net>
Subject: Re: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Thu, 25 Oct 2007 21:58:56 +0100 (BST)
Message-ID: <32932.86.7.220.119.1193345936.squirrel@wmbeta.mxes.net>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net>
    <35163.86.7.220.119.1193312862.squirrel@wmbeta.mxes.net>
    <200710251406.05804.bzolnier@gmail.com>
    <200710251411.42546.bzolnier@gmail.com>
Reply-To: "Andrew" <andrew@nelless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout-04.mxes.net ([216.86.168.179]:2323 "EHLO
	mxout-04.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbXJYU66 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 16:58:58 -0400
In-Reply-To: <200710251411.42546.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, kluo@nvidia.com, jeff@garzik.org

On Thu, October 25, 2007 13:11, Bartlomiej Zolnierkiewicz wrote:
>
>
> a better version
>
> [PATCH] sata_nv: respect swncq_enabled setting
>
>
> SWNCQ is always used despite swncq_enabled setting (which is disabled by
> default).  Fix it by using GENERIC nv_port_info[] entry for SWNCQ controllers if swncq_enabled
> is not enabled.
>

This patch worked a treat, thanks.

-
Andrew

