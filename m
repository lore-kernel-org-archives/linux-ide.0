From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Fix make mandocs for libata-core.c
Date: Mon, 30 Jan 2006 23:14:14 -0500
Message-ID: <43DEE416.5070804@pobox.com>
References: <20060131032029.GO1501@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:31465 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030221AbWAaEOZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2006 23:14:25 -0500
In-Reply-To: <20060131032029.GO1501@kurtwerks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kurt Wall <kwall@kurtwerks.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Kurt Wall wrote:
> "make mandocs" complains when on libata-core.c because several
> functions have undescribed parameters. This patch adds silences those
> warnings by adding descriptions for the undescribed parameters.
> 
> Signed-off-by: Kurt Wall <kwall@kurtwerks.com>

I appreciate the patches... Alas Randy Dunlap beat you to it.

	Jeff



