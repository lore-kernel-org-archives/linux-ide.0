From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata-dev: irq-pio minor fixes
Date: Thu, 23 Mar 2006 03:18:19 -0500
Message-ID: <442259CB.6070402@pobox.com>
References: <441FE605.8010202@tw.ibm.com> <44203953.3080803@pobox.com> <311601c90603210943v132a369aya443a073c11ee2bf@mail.gmail.com> <4422567C.5000008@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40618 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030206AbWCWISW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2006 03:18:22 -0500
In-Reply-To: <4422567C.5000008@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> irq-pio minor fixes for printk() and comments.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> 
> Patch against previous irq-pio snapshot.
> The current irq-pio branch (949ec2c8e6b7b89179b85baf6309c009e1a1b951)
> looks strange. Maybe it is under refresh.

It was rebased, which means you need to do a fresh pull.  I apologize 
for not warning you and linux-ide.  Something like

	git reset --hard 949ec2c8e6b7b89179b85baf6309c009e1a1b951

may work.  Or simply

	git checkout -f irq-pio

Or, as you say, it may be mirroring from master.kernel.org to the two 
public-facing kernel.org machines.

	Jeff



