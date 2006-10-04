From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to 1
Date: Wed, 4 Oct 2006 15:37:31 +0200
Message-ID: <c70ff3ad0610040637l4daf8f0bhec3af8c959d80ff1@mail.gmail.com>
References: <20060930104439.GP25800@htj.dyndns.org>
	 <20060930104500.GQ25800@htj.dyndns.org>
	 <20060930180359.GP4163@kernel.dk>
	 <1159649460.13029.145.camel@localhost.localdomain>
	 <20060930202628.GF5670@kernel.dk> <451F0927.2010804@emc.com>
	 <451F0BF7.1000200@gmail.com> <20061001195516.GS5670@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:37842 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030378AbWJDNhd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Oct 2006 09:37:33 -0400
Received: by nf-out-0910.google.com with SMTP id x30so482261nfb
        for <linux-ide@vger.kernel.org>; Wed, 04 Oct 2006 06:37:31 -0700 (PDT)
In-Reply-To: <20061001195516.GS5670@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <htejun@gmail.com>, Ric Wheeler <ric@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

the NCQ commands contain the FUA (force unit access) field
(mandatory), so disabling the NCQ will waste this feature.
I don't know how much ans when this feature is usuable, but someday it
can be usefull.

-saeed
