From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: pata_pdc202xx_old regression?
Date: Sat, 02 Jan 2010 20:58:27 -0600
Message-ID: <4B4007D3.3090405@gmail.com>
References: <19263.43745.540746.751448@jabber.grueslayer.com>	<4B3FB771.3070701@gmail.com> <19263.64689.654744.283071@jabber.grueslayer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752552Ab0ACC6b@vger.kernel.org>
In-Reply-To: <19263.64689.654744.283071@jabber.grueslayer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bugs+linux-ide@grueslayer.com
Cc: linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 01/02/2010 08:10 PM, David A. Sinck wrote:
>
>
>> SMTP quoth Robert Hancock on 1/2/2010 15:15 as having spake thusly:
>>
>> On 01/02/2010 02:21 PM, David A Sinck wrote:
>>>
>>> Greetings&   Happy New Year!
>>>
>>> I believe I've come across one of two things:
>>>
>>> a) a regression in pata_pdc202xx_old
>>> b) a clueless end user wrt the list :-)
>>>
>>> The short version: running Ubuntu's Jaunty release (2.6.28-17-generic
>>> #58-Ubuntu i686) I can cleanly access the disks hanging off of an
>>> onboard Promise 20265; attempting to upgrade to Ubuntu Karmic
>>> (presumptively 2.6.31.16.29) has numerious problems reading these same
>>> drives, including:
>>>
>>>     e2label: No such file or directory while trying to open /dev/sda1
>>>     Couldn't find a valid filesystem superblock.
>>>
>>> I've documented as much as I can think of that's relevant here:
>>>
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/489685
>>>
>>> I'm willing to run tests + update the bug with further information
>>> ... if I knew what would be useful.
>>>
>>> It might even be solved upstream from the release Karmic's using?
>>
>> That dmesg output is from the working setup, correct? Can you get any
>> output from the non-working one?
>
> I've uploaded /var/log/ { kern.log | syslog | dmesg } from a running
> Karmic live cd (post release); I snapshotted the whole directory but
> limited myself to those files figuring they'd be most likely to be the
> helpful ones.
>
> Let me know what else I can do; thanks for the timely response!

Well, it looks like all the drives got detected OK. I'm not sure what 
the device-mapper errors are though, and I'm not sure why you wouldn't 
be getting any device nodes showing up for them.. CCing linux-kernel.

Jan  3 01:43:51 ubuntu kernel: [    4.978003] device-mapper: table: 
252:0: zero-length target
Jan  3 01:43:51 ubuntu kernel: [    4.978009] device-mapper: ioctl: 
error adding target to table
Jan  3 01:43:51 ubuntu kernel: [    4.996613] device-mapper: table: 
252:0: zero-length target
Jan  3 01:43:51 ubuntu kernel: [    4.996620] device-mapper: ioctl: 
error adding target to table
Jan  3 01:43:51 ubuntu kernel: [    5.372214] device-mapper: table: 
252:0: zero-length target
Jan  3 01:43:51 ubuntu kernel: [    5.372221] device-mapper: ioctl: 
error adding target to table
Jan  3 01:43:51 ubuntu kernel: [    5.680349] device-mapper: table: 
252:0: zero-length target
