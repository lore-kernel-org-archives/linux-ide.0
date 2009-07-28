From: Tejun Heo <htejun@gmail.com>
Subject: Re: SiI3124 + SiI3726 pm
Date: Tue, 28 Jul 2009 11:38:26 +0900
Message-ID: <4A6E64A2.3010902@gmail.com>
References: <89d273ba0605242046x3d19dd06h74885048f229d519@mail.gmail.com> 	<89d273ba0605242202l354ec106w22bccf649e5e1dfc@mail.gmail.com> 	<44753B78.4090802@gmail.com> <c70ff3ad0605251329m34af33bfj3ace5d5f9b32af38@mail.gmail.com> 	<44761994.2050303@gmail.com> <89d273ba0907271103s787b5f06t514c219d4a551d53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:35434 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZG1CgQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jul 2009 22:36:16 -0400
Received: by pzk42 with SMTP id 42so362175pzk.33
        for <linux-ide@vger.kernel.org>; Mon, 27 Jul 2009 19:36:16 -0700 (PDT)
In-Reply-To: <89d273ba0907271103s787b5f06t514c219d4a551d53@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jerome Vuarand <jerome.vuarand@gmail.com>
Cc: linux-ide@vger.kernel.org, saeed bishara <saeed.bishara@gmail.com>

Hello, Jerome.

Jerome Vuarand wrote:
> A few months ago I updated my kernel since it now supports port
> multipliers without patch, and the issue of a supplementary port on
> the SiI3727 port multiplier rose again. Since I completely forgot
> about that 3 year old issue, I started exploring the web again before
> remembering that thread.

Hmm... this is supposed to be worked around by now.  Can you please
post boot log w/o the patch using 2.6.30?

Thanks.

-- 
tejun
