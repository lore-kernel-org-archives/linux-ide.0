From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: linux 2.6.9 controller order reordered.  was: [Re: linux 2.6.9
	still having network code problems]
Date: Tue, 02 Nov 2004 16:40:45 +0000
Message-ID: <1099413643.24934.1.camel@localhost.localdomain>
References: <418741EB.3080701@outblaze.com>
	 <20041102011918.2b453e21.akpm@osdl.org> <4187478A.1040002@outblaze.com>
	 <20041102014119.1a6096cc.akpm@osdl.org> <41874D93.9000008@outblaze.com>
	 <20041102020712.18218d47.akpm@osdl.org> <418751B3.8090003@outblaze.com>
	 <20041102022604.262058c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:16824 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261251AbUKBRnt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Nov 2004 12:43:49 -0500
In-Reply-To: <20041102022604.262058c4.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Christopher Chan <cchan@outblaze.com>, linux-ide@vger.kernel.org

On Maw, 2004-11-02 at 10:26, Andrew Morton wrote:
> Well the problem is that "Wait for ready" thing.  Was that an alanism?

What are you on about ? The problem is that in the two traces his
serverworks has moved from ide0 to ide2. 

Alan

