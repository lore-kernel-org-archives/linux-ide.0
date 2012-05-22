From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH V3 1/3] ata: pata_arasan: Add clk_{un}prepare() support
Date: Tue, 22 May 2012 16:01:33 -0400
Message-ID: <4FBBF09D.1010607@garzik.org>
References: <cover.1336536285.git.viresh.kumar@st.com> <9848a1a6838c4f3a7e0cbd6cdc3bc6146fd2e2cc.1336536285.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:54735 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab2EVUBj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 May 2012 16:01:39 -0400
Received: by qadb17 with SMTP id b17so2624762qad.19
        for <linux-ide@vger.kernel.org>; Tue, 22 May 2012 13:01:38 -0700 (PDT)
In-Reply-To: <9848a1a6838c4f3a7e0cbd6cdc3bc6146fd2e2cc.1336536285.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com, viresh.linux@gmail.com

On 05/09/2012 12:08 AM, Viresh Kumar wrote:
> clk_{un}prepare is mandatory for platforms using common clock framework. Since
> this driver is used by SPEAr platform, which supports common clock framework,
> add clk_{un}prepare() support for it.
>
> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> ---
>   drivers/ata/pata_arasan_cf.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)



these do not apply to upstream, for me...

