From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/3] libata: implement max_segment_size
Date: Sat, 16 Dec 2006 10:37:01 -0500
Message-ID: <4584129D.4030803@pobox.com>
References: <20061216104805.GC5400@htj.dyndns.org> <20061216104844.GD5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34619 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161120AbWLPQIO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Dec 2006 11:08:14 -0500
In-Reply-To: <20061216104844.GD5400@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, alan@lxorguk.ukuu.org.uk, matthias@urlichs.de, romieu@fr.zoreil.com

Tejun Heo wrote:
> libata depeneded on sht->dma_boundary for demtermining maximum segment
> size.  This is good enough for most controllers but inic1622 just had
> to be different and it locks up if segement size is 65536 while
> dma_boundary is 0xffff.
> 
> This patch implements ap->max_segment_size which can be initialized
> via probe_ent (or port_info) and used in ->slave_config to configure
> maximum segment size.  LLDs without braindamage can leave this alone.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Just implement a custom ->slave_config in the driver.  There is no need 
to add anything to probe_ent, port, and port_info.

	Jeff



