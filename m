From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH] [STACK] reduce >3k call path in ide
Date: Wed, 16 Jun 2004 14:58:19 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D0984B.3050405@didntduck.org>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de>	<20040615163445.6b886383.rddunlap@osdl.org>	<200406160911.11985.jolt@tuxbox.org>	<20040616094737.GA2548@wohnheim.fh-wedel.de>	<40D01928.1080309@tuxbox.org>	<20040616100008.GB2548@wohnheim.fh-wedel.de> <20040616103741.042f8029.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.iserv.net ([204.177.184.152]:1767 "EHLO mail2.iserv.net")
	by vger.kernel.org with ESMTP id S264530AbUFPS7A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2004 14:59:00 -0400
In-Reply-To: <20040616103741.042f8029.rddunlap@osdl.org>
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>, jolt@tuxbox.org, akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> +    tbuf = kmalloc(128 * sizeof(u_short), GFP_KERNEL);
> +    if (!tbuf) goto err_kfree;
> +    def_cte = kmalloc(sizeof(*def_cte), GFP_KERNEL);
> +    if (!def_cte) goto err_kfree;
> +    memset(def_cte, 0, sizeof(*def_cte));
> +    cfginfo = kmalloc(sizeof(*cfginfo), GFP_KERNEL);
> +    if (!cfginfo) goto err_kfree;
> +    cisparse = kmalloc(sizeof(*cisparse), GFP_KERNEL);
> +    if (!cisparse) goto err_kfree;

This can be condensed into a single kmalloc.  Define a struct that 
contains these variables and kmalloc the whole struct in one call.

--
				Brian Gerst
