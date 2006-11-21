From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19-rc6] sata_promise updates
Date: Tue, 21 Nov 2006 16:09:39 -0500
Message-ID: <45636B13.9090909@garzik.org>
References: <200611212057.kALKvL8n009798@harpo.it.uu.se> <45636A85.40700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46302 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161254AbWKUVJq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Nov 2006 16:09:46 -0500
In-Reply-To: <45636A85.40700@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 1) no_tbg_slew_init should be a bit flag ("1 << 0") inside a 'flags' 
> variable in struct pdc_host_priv.


Thinking some more, a 'is_gen_II' bit flag inside a 'flags' struct 
member would more accurately describe what the boolean flag indicates.

Once NCQ support is added, we will probably have to test this flag in 
code unrelated to TBG/slew registers.

	Jeff


