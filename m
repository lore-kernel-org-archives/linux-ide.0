From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
Date: Tue, 25 Nov 2008 11:09:45 -0800
Message-ID: <492C4D79.4050300@caviumnetworks.com>
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com> <492BDB28.8020103@ru.mvista.com> <492C2BCE.60409@caviumnetworks.com> <492C4936.2030305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:34964 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbYKYTKM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 14:10:12 -0500
In-Reply-To: <492C4936.2030305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Sergei Shtylyov wrote:
> David Daney wrote:
> 
>>>   Wrong, -DIOR hold time is 5 ns for MWDMA0 as well as for all other 
>>> modes.
> 
>> Point taken.
> 
>    Besides, I'm not sure how useful that timing could be for the host 
> controller since it's apparently not determined by the host side -- it's 
> for how long the device holds valid data after -DIOR is released IIRC.
> 

Yes, I think you are correct.  This is a property of the device and 
cannot be controlled by the driver, so I will just remove this column in 
the next version of the patch.

David Daney
