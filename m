From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ide: add support for CFA specified transfer modes
Date: Tue, 03 Mar 2009 20:58:51 +0300
Message-ID: <49AD6FDB.6060206@ru.mvista.com>
References: <200903032034.49372.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:62525 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750968AbZCCR6Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2009 12:58:24 -0500
In-Reply-To: <200903032034.49372.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, stf_xl@wp.pl

Hello, I wrote:

> Add support for the CompactFlash specific PIO modes 5/6 and MWDMA modes 3/4.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> This patch is against the current pata-2.6 series.

    Oh, and the identify word 62/63 patch that I've reposted today needs to be 
applied too.

MBR, Sergei
