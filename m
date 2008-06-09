From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Mon, 09 Jun 2008 18:17:37 +0900
Message-ID: <484CF531.30804@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200805291654.03617.volker.armin.hemmann@tu-clausthal.de> <483F804F.1@gmail.com> <200805301243.39751.volker.armin.hemmann@tu-clausthal.de> <4840A085.2080101@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B2AA19253@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:40058 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757807AbYFIJR6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jun 2008 05:17:58 -0400
Received: by rv-out-0506.google.com with SMTP id k40so210945rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 09 Jun 2008 02:17:58 -0700 (PDT)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B2AA19253@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

Peer Chen wrote:
> I think it did support NCQ function, our windows driver doesn't check
> that capability bit, so it can issue FP-DMA command no matter that bit
> being set or not.

Ah.. okay.  I see.

> For the MSI issue, I suggest just disable the MSI for MCP65 ahci
> controller, it should be hardware bug. More specifically, you can
> disable the MSI if the MCP65 ahci controller's revision ID is 0xa1 or
> 0xa2.

Okay.  I'll prep a patch for the above two issues.

> What's 64bit problem?

Hmmmm.. What was it?  Searching...  Hmmm... Anyone knows what I was
talking about?  :-)  I'll ask again when I recall.

Thanks.

-- 
tejun
