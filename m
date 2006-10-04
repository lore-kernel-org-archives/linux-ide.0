From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to 1
Date: Wed, 4 Oct 2006 15:37:55 +0200
Message-ID: <20061004133755.GP7778@kernel.dk>
References: <20060930104439.GP25800@htj.dyndns.org> <20060930104500.GQ25800@htj.dyndns.org> <20060930180359.GP4163@kernel.dk> <1159649460.13029.145.camel@localhost.localdomain> <20060930202628.GF5670@kernel.dk> <451F0927.2010804@emc.com> <451F0BF7.1000200@gmail.com> <20061001195516.GS5670@kernel.dk> <c70ff3ad0610040637l4daf8f0bhec3af8c959d80ff1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:62755 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030422AbWJDNiS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Oct 2006 09:38:18 -0400
Content-Disposition: inline
In-Reply-To: <c70ff3ad0610040637l4daf8f0bhec3af8c959d80ff1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Ric Wheeler <ric@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, Oct 04 2006, saeed bishara wrote:
> the NCQ commands contain the FUA (force unit access) field
> (mandatory), so disabling the NCQ will waste this feature.
> I don't know how much ans when this feature is usuable, but someday it
> can be usefull.

It's already useful, for io barriers. Yet another reason why the
distinction between depth == 1 and NCQ needs to available.

-- 
Jens Axboe

