From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] AHCI SATA vendor update from VIA
Date: Tue, 21 Mar 2006 11:39:38 -0500
Message-ID: <44202C4A.8030508@pobox.com>
References: <439CF812.8010107@pobox.com> <20060315191736.231a2894.vsu@altlinux.ru> <441F5C7D.2050600@pobox.com> <441FE146.3050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:2705 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751660AbWCUQjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 11:39:44 -0500
In-Reply-To: <441FE146.3050406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Geoff Rivell <grivell@comcast.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> Jeff Garzik wrote:
> 
>> Sergey Vlasov wrote:
>>
>>> What is needed to get the VT8251 support into the kernel tree?
>>
>>
>> 1) Doing what you are doing:  asking questions like this.  :)
>>
>> 2) Watching Tejun Heo's reset work.  He already has an AHCI soft reset 
>> patch, and the VIA AHCI work really depends on this.
>>
> 
> BTW, what happened to AHCI softreset patch. It got acked[1], but it has 
> not made into the tree yet. Do you want me to regenerate it against the 
> current tree? Or is there anything holding it from going into the tree?

Please resend, the only pending patch I have from you is the ATA 
transport class patch (thanks for doing that BTW), which is on hold 
waiting for SCSI updates.

	Jeff



