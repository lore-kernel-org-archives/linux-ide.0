From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/2] Added support for Designware SATA controller driver
Date: Sat, 02 May 2009 01:20:40 +0200
Message-ID: <20090501232040.3E59283420E8@gemini.denx.de>
References: <1241211767-32697-1-git-send-email-fkan@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:59210 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbZEAXUm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 May 2009 19:20:42 -0400
In-reply-to: <1241211767-32697-1-git-send-email-fkan@amcc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Feng Kan <fkan@amcc.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Mark Miesfeld <miesfeld@gmail.com>

Dear Feng Kan,

In message <1241211767-32697-1-git-send-email-fkan@amcc.com> you wrote:
> This adds support for the Designware SATA controller.
> 
> Signed-off-by: Feng Kan <fkan@amcc.com>
> Signed-off-by: Mark Miesfeld <miesfeld@gmail.com>
> ---
>  drivers/ata/Kconfig    |   10 +
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_dwc.c | 2053 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2064 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c

...
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@amcc.com>");
> +MODULE_DESCRIPTION("DesignWare Cores SATA controller low lever driver");
------------------------------------------------------------^^^^^

Guess that's a typo?

Hmm... that's 2000+ lines of code in a single file. Maybe this should
be split?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
On a clear disk you can seek forever.
