From: Tejun Heo <tj@kernel.org>
Subject: Re: Interoperability problem with Quantum CD72SH SATA tape drive
 and libata
Date: Tue, 07 Oct 2008 10:29:23 +0900
Message-ID: <48EABB73.5080002@kernel.org>
References: <48DE96AF.6090301@runbox.com> <48E2ECA8.8060808@kernel.org> <48E40415.7050607@runbox.com> <48E7D5CD.2000003@kernel.org> <48EA68D7.3060701@runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58859 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbYJGBbW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Oct 2008 21:31:22 -0400
In-Reply-To: <48EA68D7.3060701@runbox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Clark <clarkjc@runbox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

John Clark wrote:
> Tejun Heo wrote:
>> Can you please test the attached patch?
>>
>> Alan, John Clark is reporting that the above tape drive chokes on odd
>> byte PIO transfer, so the default condition check (qc->nbytes & 15) in
>> atapi_check_dma() breaks the SATA tape drive, so there's always one
>> which breaks the other way around.  :-(
>>
>> For the time being, I think the horkage should do.  I was wondering
>> whether you still think we should lift the default mod16 check in
>> atapi_check_dma().
>>
>> Thanks.
>>   
> 
> Tejun,
> 
> I have tested the patch you supplied.  It works, as expected.

applied to #tj-upstream.  Thanks.

-- 
tejun
