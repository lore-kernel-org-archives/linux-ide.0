From: Jeff Garzik <jeff@garzik.org>
Subject: Re: cached PCS
Date: Wed, 09 Aug 2006 06:46:30 -0400
Message-ID: <44D9BD06.5080103@garzik.org>
References: <44D97F07.9000301@garzik.org> <44D9AF83.80507@gmail.com> <44D9B43A.9010807@garzik.org> <44D9B4BC.5050707@gmail.com> <44D9B87A.8020507@garzik.org> <44D9BB4B.9050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56235 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030674AbWHIKqe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 06:46:34 -0400
In-Reply-To: <44D9BB4B.9050602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Keith Owens <kaos@ocs.com.au>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Jeff Garzik wrote:
>>>> Tejun Heo wrote:
>>>>> Jeff Garzik wrote:
>>>>>> can you resurrect your cached PCS patch?
>>>>>>
>>>>>> 2.6.18-rc didn't fix the ghost device and long boot delay problems 
>>>>>> for everybody.
>>>>>
>>>>> The cached PCS patch was to fix device detection failure on some 
>>>>> ICH5s where PCS is cleared while probing the first port.  Remaining 
>>>>> ghost device and long boot delay are fixed by honor-PCS patch.  Do 
>>>>> you want me to resurrect both?
>>>>
>>>> hrm.  Maybe just honor-PCS?
>>>
>>> Yeap, we need to verify whether the less-jealous-PCS-update patch 
>>> cured the ICH5 problem.
>>
>> If you are talking about the patch currently in 2.6.18-rc, I got 
>> several ACKs that it fixed their problems.
>>
>> But OTOH, there was also
>> http://marc.theaimsgroup.com/?t=115346292700002&r=1&w=2
> 
> I was talking about bugzilla bug #6724.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6724
> 
> It was a weird case of ICH5 clearing PCS present bits while the first 
> port is being probed.  The clearing happens during actual probe, that 
> is, the bits look okay till the end of the first prereset() but on entry 
> to prereset() for the second port, enabled bits are gone.  IIRC, 
> bug#6724 is different from all other reports.
> 
> I asked the reporter to test 2.6.18-rc4 and see whether the problem is 
> gone with new PCS handling.  I'm a bit skeptical about the result.  If 
> the problem remains with 2.6.18-rc4, we'll need that cached PCS to solve 
> that particular case.
> 
> BTW, do you know what Keith Owen's chipset was?

(Keith CC'd)

I didn't see lspci output, but it looks like ICH5 from his drivers/ide 
dmesg output.

Did you look at some of the other messages?  He provided some debug 
traces in follow-up messages.

	Jeff


