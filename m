From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] drivers: ide: Include appropriate header file in
 ide-cd_verbose.c
Date: Wed, 18 Dec 2013 14:23:52 +0100
Message-ID: <1930396.DGXdd6ZaUD@amdc1032>
References: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
 <52B0A93E.7090503@cogentembedded.com> <20131217190610.GJ30592@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50744 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab3LRNYL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Dec 2013 08:24:11 -0500
In-reply-to: <20131217190610.GJ30592@pd.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Josh Triplett <josh@joshtriplett.org>, Rashika Kheria <rashika.kheria@gmail.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org


Hi,

On Tuesday, December 17, 2013 08:06:10 PM Borislav Petkov wrote:
> On Tue, Dec 17, 2013 at 10:42:54PM +0300, Sergei Shtylyov wrote:
> > You're right in your doubting: there are quite a lot of drivers used
> > by embedded platforms that nobody has bothered to convert to libata
> > thus far.
> 
> Hold on, what does that mean? IDE is back from the dead and used only
> for embedded stuff?

No, it means that there are legacy PATA chipsets (some used by embedded
platforms) that are only supported by IDE host drivers.

> Or we force people to convert drivers to libata by *deleting* ide?
> 
> :-)

If there is a need I should be able to help in converting these leftover
drivers before we delete IDE.  Once I find some time I will go over all
IDE host drivers, make a list of affected hardware and start a discussion
on IDE removal.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

