From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Bugme-new] [Bug 10752] New: pata_isapnp driver causes the ata
 layer to go splat
Date: Mon, 19 May 2008 18:13:20 -0700
Message-ID: <20080519181320.54b021a9@infradead.org>
References: <bug-10752-10286@http.bugzilla.kernel.org/>
	<20080519152549.09be22b2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:33940 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759643AbYETBNc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 21:13:32 -0400
In-Reply-To: <20080519152549.09be22b2.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

On Mon, 19 May 2008 15:25:49 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> > 
> 
> Unclear who maintains pata_isapnp?

Alan is on top of this one; he sent a patch to Jeff Garzik already
earlier today
(will attach to the BZ shortly)
