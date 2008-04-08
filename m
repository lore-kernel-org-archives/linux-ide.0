From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/13] devres: implement managed iomap interface
Date: Tue, 08 Apr 2008 23:48:43 +0900
Message-ID: <47FB85CB.2070506@gmail.com>
References: <11684073371547-git-send-email-htejun@gmail.com> <47FA4FD2.8060808@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:17768 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbYDHOsx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 10:48:53 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2036054wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 08 Apr 2008 07:48:52 -0700 (PDT)
In-Reply-To: <47FA4FD2.8060808@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Sergei Shtylyov wrote:
>    A very late comment but nevertheless... :-)

Better late than never.

>    Those functions are going to break on 32-bit platforms with extended 
> physical address (well, that's starting with Pentiums which had 36-bit 
> PAE :-) AND devices mapped beyond 4 GB (e.g. PowerPC 44x).  You should 
> have used resource_size_t for the 'offset' parameter. As this most 
> probably means that libata is broken on such platforms, I'm going to 
> submit a patch...

Yeah, right please go ahead.  But I wonder whether any BIOS was actually 
crazy enough to map mmio region above 4G on 32bit machine.

-- 
tejun
