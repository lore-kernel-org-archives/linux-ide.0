From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Merging ATA passthru
Date: Fri, 21 Oct 2005 18:04:05 -0400
Message-ID: <435965D5.8010600@pobox.com>
References: <43593E0A.4070801@pobox.com> <43596160.3080407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965182AbVJUWEO@vger.kernel.org>
In-Reply-To: <43596160.3080407@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>>
>> Folks,
>>
>> Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
>> the ATA passthru work upstream, once 2.6.14 is released.
> 
> 
> Thanks, Jeff!
> 
>> Since there are still some reported problems that I haven't had time 
>> to track down, I'm going to -- like ATAPI -- introduce a module option 
>> that enables passthru.  It will default to off.
> 
> 
> With passthru, it would really be much better to just leave it enabled
> without any option.  It's NOT on any main code path, and users/distros
> have to intentionally run "smartctl -d ata" or "hdparm /dev/sd*" to
> trigger any of it.
> 
> So it is already "off", unless somebody wants to use it.

Not really true, as people constantly try (and fail) to use hdparm with 
their SATA disks today.

Anyway, I have this weird thing about not turning on something by 
default, when I know has it problems ;-)

	Jeff
