From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Mon, 04 Feb 2008 13:24:52 +0000
Message-ID: <47A712240200007800045D39@public.id2-vpn.continvity.gns.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:37450
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753724AbYBDNZC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Feb 2008 08:25:02 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

>Well, two values don't agree with each other and we know for a fact that
>vendors sometimes get PI wrong, so we trust n_ports in such cases.  We
>can reverse the behavior but that's likely to cause more problems than
>it fixes.

I understand your concern, but I think you also understand mine. So
I'm not really asking for general reversal of the logic, but to perhaps
make it just a little smarter. The (not generally usable according to
what you said earlier) experiment I made was to use the smaller of
the two sets - if either set is empty this of course wouldn't be correct.
But perhaps, if you have a non-empty port map, that should be
preferred over nr_ports? Otherwise, chipset specific knowledge may
need to be applied here (i.e. for ESB2, port map ought to always be
used)...

Jan
