From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/7] sata_promise: pdc_freeze() semantic change
Date: Wed, 11 Jul 2007 01:06:31 +0900
Message-ID: <4693AE87.6070304@gmail.com>
References: <200707071908.l67J8D5W010862@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:48288 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbXGJQGi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 12:06:38 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1062461nze
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 09:06:37 -0700 (PDT)
In-Reply-To: <200707071908.l67J8D5W010862@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: albertl@mail.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk, dwm@enoyolf.org, linux-ide@vger.kernel.org, mlord@pobox.com

Mikael Pettersson wrote:
> Albert's patch is OK as far as sata_promise is concerned, but
> I want to see an update of libata.tmpl and libata-eh.c to
> indicate the new, weakened, specification of freeze/thaw before
> I ACK this patch.

Aye aye sir.

-- 
tejun
