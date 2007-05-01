From: Stefan <gentoopower@yahoo.de>
Subject: Re: System freezes with kernel >2.6.19 - sata_nv [added crash info
 kern 2.6.21.1]
Date: Wed, 02 May 2007 01:27:38 +0200
Message-ID: <4637CCEA.8020202@yahoo.de>
References: <46351BE2.70901@yahoo.de> <4635BF4A.3050509@gmail.com> <46367F58.7000609@shaw.ca> <4636A4DC.8070606@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070701030704010205010105"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58552 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946058AbXEAX1t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 19:27:49 -0400
In-Reply-To: <4636A4DC.8070606@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070701030704010205010105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Robert Hancock wrote:
>   
>> Tejun Heo wrote:
>>     
>>> Stefan wrote:
>>>       
>>>> Hi folks,
>>>>
>>>> yesterday I upgraded  kernel 2.6.19 to 2.6.20 (gentoo kernel). Now my
>>>> box locks up about 10 min after boot.
>>>> After that I tested with a vanilla 2.6.21.1 it shows the same behavior.
>>>> I'm attaching a kern log file from the 2.6.20. The 2.6.21.1 locked up so
>>>> hard, that there was no trace left in the log file.
>>>> If I switch back to 2.6.19 everything is fine again.
>>>> If necessary I will hook up a laptop to this box, so I can capture
>>>> messages via netconsole.
>>>>         
>>> Yes please.
>>>       


Okay, I had time to set this up. I'm attaching the log messages I got
via netconsole.

>>>       
>>>> This machine is running an AMD X2 64, NFORCE4 (ASUS A8N-E)
>>>>
>>>> I haven't been following the development of libata for a while, but from
>>>> the 2.6.20 changelog It looks like there have been some major changes.
>>>>
>>>> Just let me know what kind of information you need in order to narrow it
>>>> down.
>>>>         
>>> Does giving 'sata_nv.adma=0' kernel parameter make any difference?
>>>       

I tested about 20h with adma disabled, the crash won't occur.

If I remove

sata_nv.adma=0

from boot options again it doesn't take long until my machine locks up.

[Attached dmesg output with 2.6.21.1 kernel + crash info I got via
netconsole]


I hope this is useful to you guys.

Cheers Stefan

>> If adma=0 words, then that means it's either an ADMA related problem or
>> that SAMSUNG HD401LJ drive has some problems with NCQ (since ADMA off
>> means NCQ off as well). I would say the latter is more likely.
>>     
>
> I don't have first hand experience with the particular model but I'll be
> surprised if they screwed their firmware up with new generation of
> harddisks.  Firmware on the previous generation drives was pretty good
> and they don't get worse usually.
>
>   
>> We should really have some kind of "noncq" kernel parameter we can use
>> to help debugging these problems. Though, later kernels are supposed to
>> switch it off automatically after too many errors..
>>     
>
> Till now there hasn't been any case where a broken NCQ prevented a
> machine from booting but, yeah, having such thing would be nice for
> debugging.
>
>   


--------------070701030704010205010105
Content-Type: application/x-tar;
 name="bootlog.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="bootlog.txt.gz"

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
--------------070701030704010205010105
Content-Type: application/x-tar;
 name="crashtrace.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="crashtrace.txt.gz"

H4sICOS7N0YAA2NyYXNodHJhY2UudHh0AL2YW2+jVhSF3/sr9ltnpNQ5dy5SHzxJOh1pokZy
R1U1qiIMBwfFBguOm7S/vpubAzYQmCG1LAvQXouP4wNnbb4CUMoXNqVUir8g1sZP4izZahe2
ie9tYZ+kBpRS8oevjVKnXRrFRqeh52vQ5oE0KxVtV6Z6lxh9dFWtWtFZ++kOqMMWVNkLuqCk
bW91SpBCp3gcvCBIdZYBIS5Vrgpd4rsycAPdNLFk14W3Tste6pWgrF2P209J+oi6zSaKN5AZ
LzU6yCUW5wvFhUXxFJ7xmAs3v+JowfL6dgm7JNAXECcmCiOdAnkmx517naZJeWij43vfbHGb
SoKXT3J/c8Breha4E+tnA/5+DX5yiA0etF8ORcFzbtEEYaIGubr7AMQFtL4Pt94m96PhBY5g
tj8eYC2p1ZTSKVJOmlL2irQFzHlTyidJZVMqJkntplROkQralKpJ0hawNUnaAranSGUL2Jki
Vcf/1UQ7nRwMPHmRye+BEGdvMck/XX++uSim7M/FhG3J7Vfln28+Lq/+7DOwnNJggfc36Gdf
702UxHCz87LH4uZZLf38nuBhCKubNL+hGMk/4PlFJe5DmCb/6rhpa1sNW38XgKKXuIlfsXaJ
42p5SVi+S0TxSy4FAeNtgIAfrIsTB6gHphgVAvDCWu4Iffzg2IIglXv9Pd89XpKAd9VYvW96
Oj3EdkG87iemY4gde3Zim6hOYlqOcdBPzEYQ2+QNiGkPcTnGYT8xH0NMrfmJ64f9CTErxpjS
fmIxhpjJ+Ynrp/0pcTHGlPcTyzHEXMxPLFgnMS/HWBbEootYtYklE8y2T4nFGxDLHuJyjJ1+
YmsMseTzEyvaSSzKMQ76ie0xxIrNT2yRc2KNuMUYs/LO413EzgkxsRxyNo+tmYkdbol6HruQ
JaHJXbUpluI8qpeFYkGFYvK4aK+Wvy9hG8WPcNgDXxD4uN5n8G61KvMpZRxWV0ls0mQLnJD3
RxecgnZz5cYkHUabQ6qDYuH/ggv/JeW8Uc8pbQRoP9ntt9rolwLB8zV7dbX6BIH+O8JGJAvW
Llg2FYxhzgBJ2U/rf7A1eAieUsi0b5IUWTFPEJwRtx8acEIQ9Cr0f6QRSu5S7CkwR0QZJGHY
LMypisJbjPKw0nGG7QCONffy3zqrlLX54/IM8Kk4ge/5DyjUsbfe6iAPXF5wdjBIdBb/aCA7
7Ivu6fruN8DB+uXLsjiLwrNIbE34/9ZokO5GowLhbHq3UEvllG6hLXWmdAstqWBTuoW2VE7p
FtpSe0q30JJKNqVbaEvllG6hLW0B03EdZKVV1re1C5Xckt/aLlQGrVw/0C7IUI9qFypbRw6E
76HliQ4uT7W7mvFhX3oy0h0My/A9FAHYCGJG3oCY9hDbr8UsPoaYzhllK0/WHbOq8D0QZYfD
d+0+Z8yqPHl3zKrC90C7MBy+a/c3IBbdxGX4HmrJ1BhiMWfMqjxlRzA8hu+httcaQ5y/ypmd
2BkI30OvFuwxxOoNiNUZMapsVxLXCV1C8cFce9KT5/HJ+xtBHIUhqumdB/s5eYVU9ksG6Ive
WJi/LFfiu6J37uIQi4yN3lX9S5I7jd55ge0UL7S+O3qXXvYxUfdG77pQjIjeVS3rApwnev8H
GoPUOUAZAAA=
--------------070701030704010205010105--
