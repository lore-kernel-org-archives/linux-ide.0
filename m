From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata: some last minute PCI IDs
Date: Thu, 02 Nov 2006 19:04:04 -0500
Message-ID: <454A8774.2030009@garzik.org>
References: <20061102230301.GA29659@havoc.gtf.org> <20061102153337.7e7c3e06.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:11729 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752843AbWKCAEI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Nov 2006 19:04:08 -0500
In-Reply-To: <20061102153337.7e7c3e06.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

Andrew Morton wrote:
> I think you'll find we're missing definitions for
> PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE (at least).


Whoops.  This is what happens when you deal with manually extracted MIME 
patches :/  That was sitting around uncommitted in my tree.

Checked in -- though only the _IDE symbol is needed.

	Jeff


