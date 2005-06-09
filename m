From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] SATA NCQ #4
Date: Thu, 9 Jun 2005 09:20:48 +0200
Message-ID: <20050609072047.GH5140@suse.de>
References: <20050608102857.GC18490@suse.de> <qrjda1h0sbohfdi5t57rqpp581avqcslir@4ax.com> <20050608114150.GE18490@suse.de> <20050608114526.GF18490@suse.de> <tbgea15ls0a5kovgnsr62fkhtgnspmjfeg@4ax.com> <20050609062338.GC5140@suse.de> <20050609064031.GF5140@suse.de> <42A7E52E.5040101@pobox.com> <42A7E7DF.6040903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:57554 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262318AbVFIHTt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2005 03:19:49 -0400
Content-Disposition: inline
In-Reply-To: <42A7E7DF.6040903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Grant Coady <grant_lkml@dodo.com.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 09 2005, Jeff Garzik wrote:
> Actually I wound up removing the WARN_ON(), since it broke my CONFIG_SMP 
> build here :)

Good choice :-)

-- 
Jens Axboe

