From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V3 1/2] sata_rcar: Add R-Car Gen2 SATA PHY support
Date: Fri, 29 Nov 2013 15:14:06 -0500
Message-ID: <20131129201406.GD21755@mtj.dyndns.org>
References: <1383912570-8393-1-git-send-email-valentine.barshak@cogentembedded.com>
 <1383912570-8393-2-git-send-email-valentine.barshak@cogentembedded.com>
 <52951B4D.3030205@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:43039 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab3K2UOL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Nov 2013 15:14:11 -0500
Content-Disposition: inline
In-Reply-To: <52951B4D.3030205@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>

Hello,

On Wed, Nov 27, 2013 at 02:06:05AM +0400, Valentine wrote:
> On 11/08/2013 04:09 PM, Valentine Barshak wrote:
> 
> Tejun,
> are you OK with taking this?

Yeah, the stat part looks okay to me.  How the two should be routed?
Both through libata or should I just take the first one?

Thanks.

-- 
tejun
