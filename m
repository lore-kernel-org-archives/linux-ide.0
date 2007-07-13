From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/7] sata_promise: pdc_freeze() semantic change
Date: Fri, 13 Jul 2007 18:07:28 +0900
Message-ID: <469740D0.4000104@gmail.com>
References: <200707071908.l67J8D5W010862@harpo.it.uu.se> <4693AE87.6070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:8054 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933826AbXGMJHf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 05:07:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so506494wah
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 02:07:35 -0700 (PDT)
In-Reply-To: <4693AE87.6070304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>, albertl@mail.com
Cc: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, dwm@enoyolf.org, linux-ide@vger.kernel.org, mlord@pobox.com

Tejun Heo wrote:
> Mikael Pettersson wrote:
>> Albert's patch is OK as far as sata_promise is concerned, but
>> I want to see an update of libata.tmpl and libata-eh.c to
>> indicate the new, weakened, specification of freeze/thaw before
>> I ACK this patch.

Hmmm.... The docbook document is too stale at this point.  It needs
major rewrite.  Also, I don't really think docbook is a good format for
this type of documentation.  Can we switch to formatted plain text which
can be converted to other formats?  Or use some form of inlined comment
for callback documentation which can be gathered and formatted
automatically?

Albert, do you mind updating the comment in libata-eh.c?

-- 
tejun
