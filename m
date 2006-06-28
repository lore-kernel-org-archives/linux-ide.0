From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add host_set->next for legacy two host_sets
	case, take #3
Date: Wed, 28 Jun 2006 12:38:52 +0100
Message-ID: <1151494733.15166.18.camel@localhost.localdomain>
References: <20060612051727.GD9166@htj.dyndns.org>
	 <448D0FF9.1080605@pobox.com> <20060612101419.GB5751@htj.dyndns.org>
	 <448D6DBF.9010604@pobox.com> <20060612140538.GA3892@htj.dyndns.org>
	 <44A25979.3020709@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:60806 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932777AbWF1LfY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jun 2006 07:35:24 -0400
In-Reply-To: <44A25979.3020709@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Brian King <brking@us.ibm.com>, Doug Maxey <dwm@bebe.enoyolf.org>, Unicorn Chang <uchang@tw.ibm.com>

Ar Mer, 2006-06-28 am 18:27 +0800, ysgrifennodd Albert Lee:
> Hmm, the current patch looks more like a temporary solution. The legacy mode
> ATA_HOST_SIMPLEX host_set->flags could be assigned to both legacy ports.
> In the long term, have one host_set for both legacy ports
> instead of two host_sets for both legacy ports can fix the problem.

I'm diddling with this at the moment. Following up on Jeffs request that
there should be a single host_set in such cases since its the same pci
device.

Alan

