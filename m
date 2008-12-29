From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: k3b won't burn, nerolinux will
Date: Mon, 29 Dec 2008 14:27:02 -0600
Message-ID: <49593296.1080101@shaw.ca>
References: <200812290933.20277.ale@pcartwright.com> <200812291101.32026.ale@pcartwright.com> <alpine.DEB.1.10.0812291128000.23543@p34.internal.lan> <200812291223.34191.ale@pcartwright.com> <alpine.DEB.1.10.0812291432440.28158@p34.internal.lan> <alpine.DEB.1.10.0812291521490.30626@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:42480 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbYL2U1Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 15:27:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHOhk-0001V8-Ez
	for linux-ide@vger.kernel.org; Mon, 29 Dec 2008 20:27:12 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 29 Dec 2008 20:27:12 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 29 Dec 2008 20:27:12 +0000
In-Reply-To: <alpine.DEB.1.10.0812291521490.30626@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Paul Cartwright <ale@pcartwright.com>

Justin Piszcz wrote:
> 
> 
> On Mon, 29 Dec 2008, Justin Piszcz wrote:
> 
>>
>>
>> On Mon, 29 Dec 2008, Paul Cartwright wrote:
>>
>>> On Mon December 29 2008, you wrote:
>>>> Please install dvd+rw-tools as shown above (apt-get install it)
>>>>
>>> already installed:
>>> ~$ dpkg --list|grep dvd+rw
>>> ii  dvd+rw-tools                                            7.1-3
>>> DVD+-RW/R tools
>>>
>>>
>>>> Then:
>>>>
>>>> Burn a DVD using the command:
>>>> growisofs -Z /dev/hda=FC-6-i386-DVD.iso
>>> how about:
>>> growisofs -Z /dev/scd0 k3b.project.iso (existing file)
>>>
>>>
>>>>
>>>> Or a CD:
>>>> cdrecord dev=/dev/scd0 -eject -v -dao driveropts=burnfree speed=48 
>>>> -data
>>>> file.iso
>>>>
>>>> Then, please provide the output from that application/burn-run.  I
>>>> recommend you do this to isolate the problem.
>>> # growisofs -Z /dev/scd0 K3b.project.iso
>>> Executing 'genisoimage K3b.project.iso | builtin_dd of=/dev/scd0 obs=32k
>>> seek=0'
>>> I: -input-charset not specified, using utf-8 (detected in locale 
>>> settings)
>>>  0.52% done, estimate finish Mon Dec 29 12:20:31 2008
>>>  1.05% done, estimate finish Mon Dec 29 12:20:31 2008
>>>  1.57% done, estimate finish Mon Dec 29 12:20:31 2008
>>> /dev/scd0: "Current Write Speed" is 16.4x1352KBps.
>>>  2.09% done, estimate finish Mon Dec 29 12:37:15 2008
>>>  2.61% done, estimate finish Mon Dec 29 12:34:32 2008
>>>  3.14% done, estimate finish Mon Dec 29 12:32:44 2008
>>>  3.66% done, estimate finish Mon Dec 29 12:31:26 2008
>>>  4.18% done, estimate finish Mon Dec 29 12:30:52 2008
>>>  4.70% done, estimate finish Mon Dec 29 12:30:04 2008
>>>  5.23% done, estimate finish Mon Dec 29 12:29:26 2008
>>>  5.75% done, estimate finish Mon Dec 29 12:28:55 2008
>>>  6.27% done, estimate finish Mon Dec 29 12:28:29 2008
>>>  6.80% done, estimate finish Mon Dec 29 12:28:07 2008
>>>  7.32% done, estimate finish Mon Dec 29 12:27:48 2008
>>>  7.84% done, estimate finish Mon Dec 29 12:27:31 2008
>>>  8.36% done, estimate finish Mon Dec 29 12:27:17 2008
>>>  8.89% done, estimate finish Mon Dec 29 12:27:04 2008
>>>  9.41% done, estimate finish Mon Dec 29 12:26:53 2008
>>>  9.93% done, estimate finish Mon Dec 29 12:26:43 2008
>>> 10.45% done, estimate finish Mon Dec 29 12:26:34 2008
>>> 10.98% done, estimate finish Mon Dec 29 12:26:26 2008
>>> 11.50% done, estimate finish Mon Dec 29 12:26:18 2008
>>> 12.02% done, estimate finish Mon Dec 29 12:26:12 2008
>>> 12.55% done, estimate finish Mon Dec 29 12:26:05 2008
>>> 13.07% done, estimate finish Mon Dec 29 12:26:00 2008
>>> 13.59% done, estimate finish Mon Dec 29 12:25:54 2008
>>> 14.11% done, estimate finish Mon Dec 29 12:25:49 2008
>>> 14.64% done, estimate finish Mon Dec 29 12:25:45 2008
>>> 15.16% done, estimate finish Mon Dec 29 12:25:41 2008
>>> 15.68% done, estimate finish Mon Dec 29 12:25:37 2008
>>> 16.20% done, estimate finish Mon Dec 29 12:25:33 2008
>>> 16.73% done, estimate finish Mon Dec 29 12:25:29 2008
>>> 17.25% done, estimate finish Mon Dec 29 12:25:26 2008
>>> 17.77% done, estimate finish Mon Dec 29 12:25:23 2008
>>> 18.29% done, estimate finish Mon Dec 29 12:25:20 2008
>>> 18.82% done, estimate finish Mon Dec 29 12:25:17 2008
>>> 19.34% done, estimate finish Mon Dec 29 12:25:15 2008
>>> 19.86% done, estimate finish Mon Dec 29 12:25:12 2008
>>> 20.39% done, estimate finish Mon Dec 29 12:25:10 2008
>>> 20.91% done, estimate finish Mon Dec 29 12:25:08 2008
>>> 21.43% done, estimate finish Mon Dec 29 12:25:06 2008
>>> 21.95% done, estimate finish Mon Dec 29 12:25:04 2008
>>> 22.48% done, estimate finish Mon Dec 29 12:25:02 2008
>>> 23.00% done, estimate finish Mon Dec 29 12:25:00 2008
>>> 23.52% done, estimate finish Mon Dec 29 12:24:58 2008
>>> 24.04% done, estimate finish Mon Dec 29 12:24:57 2008
>>> 24.57% done, estimate finish Mon Dec 29 12:24:55 2008
>>> 25.09% done, estimate finish Mon Dec 29 12:24:50 2008
>>> 25.61% done, estimate finish Mon Dec 29 12:24:48 2008
>>> 26.14% done, estimate finish Mon Dec 29 12:24:47 2008
>>> 26.66% done, estimate finish Mon Dec 29 12:24:46 2008
>>> 27.18% done, estimate finish Mon Dec 29 12:24:44 2008
>>> :-[ WRITE@LBA=3c2d0h failed with SK=3h/ASC=80h/ACQ=04h]: Input/output 
>>> error
>>> :-( write failed: Input/output error
>>> /dev/scd0: flushing cache
>>> /dev/scd0: updating RMA
>>> /dev/scd0: closing session
>>
> 
>  CC'd linux-ide for ideas here.
> 
>  Also, they may ask you to try a burn with speed=1 to eliminate any weird
>  bottlenecks or bad media.

We don't have the full back story here.. The drive apparently returned 
an error code that's listed as vendor-specific in the MMC specs, so hard 
to say what it's trying to tell you.

