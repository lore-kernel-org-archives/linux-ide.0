From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Mon, 13 Oct 2008 09:27:21 -0400
Message-ID: <48F34CB9.3020000@pobox.com>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru> <48F2F138.6020103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761582AbYJMN1h@vger.kernel.org>
In-Reply-To: <48F2F138.6020103@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Anton Vorontsov wrote:
>> When no irq specified the pata_of_platform fills the irq_res with -1,
>> which is wrong to do for two reasons:
>>
>> 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
>> 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
>>    is unsigned type, the check will be true for `-1'.
>>
>> Reported-by: Steven A. Falco <sfalco@harris.com>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> applied to #tj-upstream (will soon be sent upstream)

I have returned!  muhahahahahaha....
