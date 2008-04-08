From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/13] devres: implement managed iomap interface
Date: Wed, 09 Apr 2008 00:03:36 +0900
Message-ID: <47FB8948.9090302@gmail.com>
References: <11684073371547-git-send-email-htejun@gmail.com> <47FA4FD2.8060808@ru.mvista.com> <47FB85CB.2070506@gmail.com> <47FB8751.3040301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:3120 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbYDHPDo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 11:03:44 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2035633wff.4
        for <linux-ide@vger.kernel.org>; Tue, 08 Apr 2008 08:03:44 -0700 (PDT)
In-Reply-To: <47FB8751.3040301@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Sergei Shtylyov wrote:
>> Yeah, right please go ahead.  But I wonder whether any BIOS was 
>> actually crazy enough to map mmio region above 4G on 32bit machine.
> 
>    This is a *hardware* mapping on some non-x86 platforms (like PPC 44x 
> or MIPS Alchemy). The arch/ppc/ and arch/mips/ kernels have special 
> hooks called from ioremap() which help create an illusion that the PCI 
> memory space on such platforms (not only it) is mapped below 4 GB; 
> arch/powerpc/ kernel doesn't do this anymore -- hence this newly 
> encountered issue.

Ah... I see.  Thanks for the clarification.

-- 
tejun
