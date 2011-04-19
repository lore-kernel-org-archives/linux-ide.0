From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata-sff/pata_cmd64x problem with hardwired configurations
Date: Tue, 19 Apr 2011 13:50:12 +0200
Message-ID: <BANLkTinCN3_ex1w3vWBbkBLhUx2UW+Xrhw@mail.gmail.com>
References: <1303084704.2583.23.camel@mulgrave.site>
	<1303142114.7167.6.camel@mulgrave.site>
	<4DAC63EA.4000707@ru.mvista.com>
	<201104191120.31061.bzolnier@gmail.com>
	<20110419110838.3deafeff@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38095 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab1DSLuN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2011 07:50:13 -0400
Received: by qwk3 with SMTP id 3so2857257qwk.19
        for <linux-ide@vger.kernel.org>; Tue, 19 Apr 2011 04:50:12 -0700 (PDT)
In-Reply-To: <20110419110838.3deafeff@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide <linux-ide@vger.kernel.org>, 622997@bugs.debian.org

On Tue, Apr 19, 2011 at 12:08 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Subject: [PATCH v2] pata_cmd64x: add enablebits checking
>>
>> Fixes IDE -> libata regression.
>
> And causes a regression too

Could you be more explicit?

Regression in this patch would mean that old driver currently doesn't
work which is not true..

Thanks,
Bartlomiej
