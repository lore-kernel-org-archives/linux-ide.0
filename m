From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Tue, 01 Nov 2011 09:19:19 +0400
Message-ID: <1320124759.7701.2.camel@dabdike>
References: <20111026202235.GA20928@havoc.gtf.org>
	 <1319969101.5215.20.camel@dabdike>
	 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
	 <4EAF1731.2070908@zytor.com>
	 <CA+55aFy-qDrzi21EWWV1yxDoRzh5xzLR6ai6Cq1b+hMrNTk6Sw@mail.gmail.com>
	 <4EAF1FF6.3000500@zytor.com>
	 <CA+55aFw-kvshWmAVFVSa11cNU0AbAu3R5djboR8ysj0tYp1p-A@mail.gmail.com>
	 <alpine.DEB.2.02.1110311915160.31794@asgard.lang.hm>
	 <4EAF66C7.6080909@zytor.com>
	 <CA+55aFwycceEN7itYama6H4gwAK-OQdqZ5uo9Pdg9ATqPTPtWQ@mail.gmail.com>
	 <3f01b4a5-8dfa-4eb4-bfa3-490d5ebf0281@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36445 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750779Ab1KAFTZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2011 01:19:25 -0400
In-Reply-To: <3f01b4a5-8dfa-4eb4-bfa3-490d5ebf0281@email.android.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "hpanvin@gmail.com" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, david@lang.hm, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, 2011-10-31 at 21:25 -0700, hpanvin@gmail.com wrote:
> Body searches are still slow, at least with dovecot on the server.  No
> idea about gmail as the server.

Actually, my experience is different.  I do use body searches a lot (not
TSA approved ones, obviously) and I found they're much faster after
switching to dovecot (from wu-imapd).  However, they also burn massive
amounts of CPU time on my server, so it probably helps that I only have
a couple of mail users.

James


