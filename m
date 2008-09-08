From: Tejun Heo <tj@kernel.org>
Subject: Re: Intel AHCI ICH9R not detecting devices
Date: Mon, 08 Sep 2008 13:35:59 +0200
Message-ID: <48C50E1F.9040407@kernel.org>
References: <WorldClient-F200808221729.AA29360172@butn.net> <48B92399.6010808@kernel.org> <WorldClient-F200808302142.AA42270030@butn.net> <48BBB248.7090904@kernel.org> <WorldClient-F200809062012.AA12270277@butn.net> <WorldClient-F200809062331.AA31030286@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35586 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbYIHLhl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 07:37:41 -0400
In-Reply-To: <WorldClient-F200809062331.AA31030286@butn.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: xerces8 <xerces8@butn.net>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, stein@hermes.si

xerces8 wrote:
> I put more debug in the function that failed and tracked the problem down to setup_irq().
> I also enabled CONFIG_DEBUG_SHIRQ. The kernel messages are attached.

Aieee... please disable ide-generic.

-- 
tejun
