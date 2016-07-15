From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/10] ata: add ata_is_fpdma() accessor
Date: Fri, 15 Jul 2016 08:13:19 +0200
Message-ID: <20160715061319.GA22469@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de> <1468454751-12466-5-git-send-email-hch@lst.de> <20160714143756.GF15005@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36457 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbcGOGNW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Jul 2016 02:13:22 -0400
Content-Disposition: inline
In-Reply-To: <20160714143756.GF15005@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Hi Rejun, hi Hannes,

Damien and I spent some time going over this patch today and we think
it's best to simply drop it.  
