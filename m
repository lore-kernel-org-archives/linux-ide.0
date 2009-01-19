From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 2/6] DMI: Introduce dmi_first_match to make the interface more flexible
Date: Mon, 19 Jan 2009 22:15:24 +0100
Message-ID: <200901192215.27650.elendil@planet.nl>
References: <20081104062734.GA4420@havoc.gtf.org> <200901192053.50831.rjw@sisk.pl> <200901192055.51108.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml19.KPNXCHANGE.COM ([213.75.38.84]:30838 "EHLO
	hpsmtp-eml19.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753250AbZASVPa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 16:15:30 -0500
In-Reply-To: <200901192055.51108.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, tj@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 19 January 2009, Rafael J. Wysocki wrote:
> +const struct dmi_system_id *dmi_first_match(const struct dmi_system_id
> *list)
> +{ 
> +       const struct dmi_system_id *d;
> +
> +       for (d = list; d->ident; d++)
> +               if (dmi_matches(d))
> +                       return d;
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL(dmi_first_match);

I did indeed have an older version of the patches (before you split them 
out) and that was missing the "const" in the first quoted line, so that 
explains the warning I had.

If I compare the version I've been running with the past months and this 
series I see only minor changes and I don't expect any problems from 
them. If I notice anything I'll let you know. No news is good news :-)

Thanks,
FJP
