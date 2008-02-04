From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Mon, 04 Feb 2008 22:38:00 +0900
Message-ID: <47A71538.50803@gmail.com>
References: <47A712240200007800045D39@public.id2-vpn.continvity.gns.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:11772 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbYBDNiJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:38:09 -0500
Received: by py-out-1112.google.com with SMTP id u52so3282630pyb.10
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:38:07 -0800 (PST)
In-Reply-To: <47A712240200007800045D39@public.id2-vpn.continvity.gns.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Jan Beulich wrote:
> I understand your concern, but I think you also understand mine. So
> I'm not really asking for general reversal of the logic, but to perhaps
> make it just a little smarter. The (not generally usable according to
> what you said earlier) experiment I made was to use the smaller of
> the two sets - if either set is empty this of course wouldn't be correct.
> But perhaps, if you have a non-empty port map, that should be
> preferred over nr_ports? Otherwise, chipset specific knowledge may
> need to be applied here (i.e. for ESB2, port map ought to always be
> used)...

Yes, we can be more smart if necessary.  I don't know.  The hardware is
clearly violating the spec which requires those two values to agree.
What status values are you seeing?  Hardware vendors usually don't get
n_ports wrong from the start, they probably have forgotten to decrement
it by one when one of the ports is plugged for some reason.  I bet the
silicon for the port is there and reporting offline PHY, right?

-- 
tejun
