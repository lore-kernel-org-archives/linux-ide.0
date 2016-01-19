From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata: disable forced PORTS_IMPL for >= AHCI 1.3
Date: Tue, 19 Jan 2016 12:22:17 -0500
Message-ID: <20160119172217.GQ3520@mtj.duckdns.org>
References: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
 <20160114223732.GG3520@mtj.duckdns.org>
 <20160115201305.GN3520@mtj.duckdns.org>
 <569A16E1.7010708@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33567 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174AbcASRWT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2016 12:22:19 -0500
Content-Disposition: inline
In-Reply-To: <569A16E1.7010708@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jan 16, 2016 at 01:09:37PM +0300, Sergei Shtylyov wrote:
> >+	/* fabricate port_map from cap.nr_ports for < AHCI 1.3 */
> >+	if (!port_map && (!(vers >> 16) ||
> >+			  ((vers >> 16) == 1 && (vers & 0xFFFF) < 0x300))) {
> 
>     Hm, won't just (vers < 0x1300) just work?

lol, indeed.  Lemme update the patch.

Thanks.

-- 
tejun
