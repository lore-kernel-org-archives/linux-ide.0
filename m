From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 22:24:05 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040329052405.GG6405@bounceswoosh.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <20040328044029.GB1984@bounceswoosh.org> <40667734.8090203@yahoo.com.au> <20040328203357.GB6405@bounceswoosh.org> <20040328205917.GF6405@bounceswoosh.org> <40677C21.7070807@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:51890 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262625AbUC2FX1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Mar 2004 00:23:27 -0500
Content-Disposition: inline
In-Reply-To: <40677C21.7070807@yahoo.com.au>
List-Id: linux-ide@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Mon, Mar 29 at 11:30, Nick Piggin wrote:
>Well strictly, you send them one after the other. So unless you
>have something similar to our anticipatory scheduler or plugging
>mechanism, the drive should attack the first one first, shouldn't
>it?

If you send 32 commands to our disk at once (TCQ/NCQ) we send 'em all
to our back-end disk engine as fast as possible.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

