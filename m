From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 16:32:13 -0500
Message-ID: <4B182E5D.2020905@garzik.org>
References: <4B1771CD.3090409@garzik.org>	<20091203165947.13841802@lxorguk.ukuu.org.uk>	<4B17F7E4.9040302@garzik.org> <20091203.124804.168589603.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755462AbZLCVcM@vger.kernel.org>
In-Reply-To: <20091203.124804.168589603.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 12/03/2009 03:48 PM, David Miller wrote:
> From: Jeff Garzik<jeff@garzik.org>
> Date: Thu, 03 Dec 2009 12:39:48 -0500
>
>> On 12/03/2009 11:59 AM, Alan Cox wrote:
>>>> The merge window is upon us, which by strict rules means that anything
>>>> not already in libata-dev.git#upstream needs to wait until 2.6.34.
>>>
>>> Not quite yet - Linus hasn't said "go"
>>
>> He rarely if ever says "go."  The kernel X is released, and people
>> send pull requests to Linus for X+1.  He typically merges immediately,
>> but does not push out the first set of merges for a few days.
>
> I don't think he even starts pulling until 1 or 2 days later.
>
> I personally never send him a pull request until a day or two in.

<shrug>  In the past he has commented on pulls, indicating some sort of 
immediate action, yet not pushed for a few days.

Not a big deal.  Plenty of other people send pull requests immediately, 
even if you ignore the high-volume Ingo special case <chuckle>

In any case, the basic point is that Linus does not say "go" for merge 
windows.  People send, he pulls when he chooses, and pushes when he 
chooses.  It's all very zen ;-)

	Jeff
