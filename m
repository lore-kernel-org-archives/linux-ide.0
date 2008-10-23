From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: set device class to NONE if phys_offline
Date: Thu, 23 Oct 2008 12:01:38 +0900
Message-ID: <48FFE912.9050508@kernel.org>
References: <48FDF5D6.20707@kernel.org> <48FEFF23.5090006@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37562 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbYJWDB5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 23:01:57 -0400
In-Reply-To: <48FEFF23.5090006@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Sergei Shtylyov wrote:
>> As on/offliness semantics is strictly defined and used in multiple
>>   
> 
>   More grammar nitpicking: it's either on/offline or on/offlineness. :-)

Right.  I'll keep it in mind.  I'm so glad that you're reviewing
libata changes.  Thanks.  :-)

-- 
tejun
