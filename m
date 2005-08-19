From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git] libata-dev queue updated
Date: Fri, 19 Aug 2005 13:45:02 -0400
Message-ID: <43061A9E.4050408@pobox.com>
References: <20050819035437.GA18324@havoc.gtf.org> <4305C5AA.20200@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:37085 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932665AbVHSRpQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Aug 2005 13:45:16 -0400
In-Reply-To: <4305C5AA.20200@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org

Brett Russ wrote:
> Jeff Garzik wrote:
> 
>> In such cases, patches are divided into branches by category: ncq (NCQ
>> queueing support), chs-support (C/H/S support), adma (new ADMA driver),
>> sil24 (new Silicon Image 312x driver), passthru (ATA passthrough/SMART
>> support), etc.
>>  
>>
> Jeff,
> The below doesn't seem to include NCQ. Is this an oversight?

No.  NCQ is a separate branch, for now.

	Jeff



