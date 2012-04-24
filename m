From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V2 4/9] ata/sata_mv: Remove conditional compilation of
 clk code
Date: Tue, 24 Apr 2012 12:35:23 +0530
Message-ID: <4F9650B3.9030406@st.com>
References: <20120424070426.GA24089@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:56293 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754543Ab2DXHHY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Apr 2012 03:07:24 -0400
In-Reply-To: <20120424070426.GA24089@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "sshtylyov@mvista.com" <sshtylyov@mvista.com>, spear-devel <spear-devel@list.st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "jgarzik@redhat.com" <jgarzik@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 4/24/2012 12:34 PM, Andrew Lunn wrote:
> I don't think this change is correct. With the old semantics, it was:

Sorry. :(

> If we have CLK support, we expect there to be a clock for sata_mv, and
> if there is no such clock, output a notice message, something is
> probably wrong, i expected there to be a clock.
> 
> The new semantics are:
> 
> We expect there to be a clock for sata_mv, and if there is no such
> clock, output a notice message, something is probably wrong, i
> expected there to be a clock.
> 
> We are going to see this notice message much more, when it is not
> expected.

So, the only problem is this message?
How do you suggest to tackle this now. Have #ifdef,#endif around this print?

-- 
viresh
