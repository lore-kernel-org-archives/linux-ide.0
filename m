From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/13] devres: implement managed iomap interface
Date: Fri, 11 Apr 2008 11:08:35 +0900
Message-ID: <47FEC823.9000100@gmail.com>
References: <11684073371547-git-send-email-htejun@gmail.com>	<47FA4FD2.8060808@ru.mvista.com> <47FB85CB.2070506@gmail.com> <47FB8751.3040301@ru.mvista.com> <47FE46AC.5000901@ru.mvista.com> <59A939C7-75AF-4C0F-8199-4C31D174AEA9@kernel.crashing.org> <47FE5B76.40409@ru.mvista.com> <A567023C-17FC-402D-9394-29DFFA816891@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.156]:63094 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbYDKCIm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 22:08:42 -0400
Received: by po-out-1718.google.com with SMTP id y22so415939pof.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 19:08:42 -0700 (PDT)
In-Reply-To: <A567023C-17FC-402D-9394-29DFFA816891@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, gregkh@suse.de, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk

Kumar Gala wrote:
>>> but there is no reason not to make it work properly.  For example I  
>>> believe libata uses devm_* and the fsl SATA driver (non-PCI) will 
>>> need  to work in cases similar to the 44x.
>>
>>   Well, as for sata_fsl, it calls of_iomap() which does The Right Thing.
> 
> Fair, but I don't see why we should introduce new APIs that are already 
> "broken".  We went through a lot of effort to clean up and introduce 
> resource_t (and clearly still have some bugs) for the >32-bit physical 
> address problem.

Yes, please go ahead.  In case it wasn't clear, I wasn't objecting to 
the fix at all.  I was just curious what could actually happen on x86.

-- 
tejun
