From: John Clark <clarkjc@runbox.com>
Subject: Re: Interoperability problem with Quantum CD72SH SATA tape drive
 and libata
Date: Mon, 06 Oct 2008 15:36:55 -0400
Message-ID: <48EA68D7.3060701@runbox.com>
References: <48DE96AF.6090301@runbox.com> <48E2ECA8.8060808@kernel.org> <48E40415.7050607@runbox.com> <48E7D5CD.2000003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aibo.runbox.com ([193.71.199.94]:58831 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbYJFThe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Oct 2008 15:37:34 -0400
In-Reply-To: <48E7D5CD.2000003@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Can you please test the attached patch?
>
> Alan, John Clark is reporting that the above tape drive chokes on odd
> byte PIO transfer, so the default condition check (qc->nbytes & 15) in
> atapi_check_dma() breaks the SATA tape drive, so there's always one
> which breaks the other way around.  :-(
>
> For the time being, I think the horkage should do.  I was wondering
> whether you still think we should lift the default mod16 check in
> atapi_check_dma().
>
> Thanks.
>   

Tejun,

I have tested the patch you supplied.  It works, as expected.

Thanks.

- John
