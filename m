From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] libata: improve ata_bus_probe failure handling, take
 2
Date: Tue, 04 Apr 2006 09:11:57 -0400
Message-ID: <4432709D.2080708@pobox.com>
References: <11439680863256-git-send-email-htejun@gmail.com>	 <442FE142.7030304@pobox.com> <4430ECEF.30307@tw.ibm.com>	 <4430FB37.6040600@pobox.com>	 <87f94c370604030737y7ef96ed8g5d887ff768845956@mail.gmail.com>	 <44314B32.1070004@pobox.com> <87f94c370604040602i7b9a5bbfu6c9285d77c5f75ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:19661 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964883AbWDDNMD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2006 09:12:03 -0400
In-Reply-To: <87f94c370604040602i7b9a5bbfu6c9285d77c5f75ed@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Greg Freemyer wrote:
> On 4/3/06, Jeff Garzik <jgarzik@pobox.com> wrote:
>> Greg Freemyer wrote:
>>> On 4/3/06, Jeff Garzik <jgarzik@pobox.com> wrote:
>>>
>>>> For the record, I do consider irq-pio upstream ready.  It still needs to
>>>> wait for Tejun's EH work to make it upstream, to give upstream people
>>>> the test sets of
>>>>
>>>>         - prep EH (2.6.17-rc1)
>>>>         - EH
>>>>         - NCQ
>>>>         - irq-pio
>>>>
>>>> Since each of these sets is staged, upstream testers will be able to say
>>>> "2.6.17-rc1 works, but 2.6.18-git1 doesn't", which gives us a lot of
>>>> good info.
>>>>
>>>>         Jeff
>>> So for those of us anxiously waiting for the above great enhancements
>>> it looks like it will be 5 months or so before it is in a released
>>> vanilla kernel?  ie. assuming 2 1/2 months per kernel release.
>> Heavens no :)
>>
>> The stages above just need to be separated out by a few 2.6.X-gitX or
>> 2.6.X-rcX releases.
>>
>>         Jeff
> 
> I'm confused.  You just poseted:
> 
>> Due to the merge window closing, the three pending patchsets will be in
>> 2.6.18.
> 
> That sure sounds like 5 months before it is in a released vanilla
> kernel.  ie. it has been taking about 10 weeks per kernel release. 
> 2.6.17 is likely to take another 8 weeks.  Then 10 weeks for 2.6.18 to
> come out.

Hopefully the releases won't take that long :)

	Jeff



