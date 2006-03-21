From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: [PATCH/RFC] libata-dev: handle ERR=1 DRQ=1
Date: Tue, 21 Mar 2006 10:43:52 -0700
Message-ID: <311601c90603210943v132a369aya443a073c11ee2bf@mail.gmail.com>
References: <441FE605.8010202@tw.ibm.com> <44203953.3080803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:22459 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751460AbWCURnx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 12:43:53 -0500
Received: by pproxy.gmail.com with SMTP id t32so2145070pyc
        for <linux-ide@vger.kernel.org>; Tue, 21 Mar 2006 09:43:53 -0800 (PST)
In-Reply-To: <44203953.3080803@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

On 3/21/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> If DRQ==1 then the error register and ATA_ERR should be considered
> irrelevant.  I agree with Eric, that's more of a "don't touch it, other
> than to SRST it" situation.
>
>         Jeff

Well, some applications want to know the drive's best-guess at the
data, as there are some cases where the resulting data resembles the
original and might be useful even in its partial-block form.

Of course, many errors result in absolute garbage, so it's probably
only useful for a very limited set of applications, that in most cases
already know roughly what type of data is in the bad block.

--eric
