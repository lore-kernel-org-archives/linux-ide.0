From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] sata_sil: disable DMA engine in ->freeze
Date: Wed, 08 Apr 2009 01:17:11 -0400
Message-ID: <49DC3357.3030703@garzik.org>
References: <20090407232247.GA16086@havoc.gtf.org>	 <20090407232331.GA16190@havoc.gtf.org> <3fb94e50904072213n637525b1w4b032544dcef3618@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38375 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbZDHFRP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 01:17:15 -0400
In-Reply-To: <3fb94e50904072213n637525b1w4b032544dcef3618@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, d.harrison@sutus.com

Sagar Borikar wrote:
> This patch works for our platform.

Did you try both patches together?  Both are required for the solution.

	Jeff



