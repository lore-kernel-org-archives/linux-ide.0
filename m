From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata_piix: minor typo and a printk fix
Date: Mon, 30 Sep 2013 15:36:28 -0400
Message-ID: <20130930193628.GA8091@htj.dyndns.org>
References: <52459308.1040905@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f176.google.com ([209.85.213.176]:43345 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307Ab3I3Tgc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Sep 2013 15:36:32 -0400
Received: by mail-ye0-f176.google.com with SMTP id m4so1900014yen.21
        for <linux-ide@vger.kernel.org>; Mon, 30 Sep 2013 12:36:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52459308.1040905@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <levex@linux.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

Tried to apply it but patch seems whitespace damaged and doesn't
apply.  Please resend.  Also, one comment.

On Fri, Sep 27, 2013 at 04:15:36PM +0200, Levente Kurusa wrote:
> -	ICH5_PMR		= 0x90, /* port mapping register */
> +	ICH5_PMR		= 0x90, /* address map register */

I don't know whether the name has changed but PMR at least did stand
for Port Mapping Register.  I don't see much point in updating the
comment here.

Thanks.

-- 
tejun
