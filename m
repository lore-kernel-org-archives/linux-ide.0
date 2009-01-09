From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use   HORKAGE_NOSETXFER
Date: Thu, 08 Jan 2009 18:11:00 -0600
Message-ID: <49669614.2080801@shaw.ca>
References: <20090107141536.231980@gmx.net> <20090107142351.79749c05@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:11165 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbZAIALF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2009 19:11:05 -0500
In-Reply-To: <20090107142351.79749c05@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Moritz Rigler <moritz1234567@gmx.de>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> The problem appears at least on two models (Sony Vaio FW and Sony Vaio VGN-NS11S). So I really don't agree with you "one report, from one user, with one configuration, on one controller, using one firmware set" statement, Alan.
> 
> Thanks - yours was the only one I had seen references too. I don't spend
> my days reading the Ubuntu forums.
> 
>> (where issues like this have not been fixed yet).
> 
> Its probably a better idea to buy a computer that appears to work in the
> way it is expected yes. However there is more to making a good quality
> OS than running around flapping at every warped piece of hardware we
> meet. It would be good if this works but it would also be good to know
> therefore why it happens to work in Vista - are the delays longer, are
> they clearing some other undefined command bits that the spec says don't
> matter etc.
> 
> Simply saying 'oh it didn't work lets just pretend we don't care' isn't
> always a good idea, particuarly when the worst case failure for it on
> other devices where it indicates a real failing might be corruption of
> user data.
> 
> Yes - I'd like it to just work, but I'd like it to just work without
> breaking anything else, without adding device specific special cases and
> ideally in a way that makes other stuff that is similarly odd just work
> too.

I wonder if whatever storage driver Sony has it set up to run with in 
Vista is just skipping the set transfer mode command on SATA devices?

If you guys still have the Vista install, can you tell us what driver 
it's using in Windows (the Intel one, standard Microsoft AHCI, etc?)
